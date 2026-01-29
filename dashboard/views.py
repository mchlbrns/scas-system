from rest_framework import viewsets, response, status
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from django.db.models import Sum
from datetime import datetime, date, timedelta
import calendar

from clients.models import Client
from analysts.models import Analyst
from targets.models import Target
from receivables.models import Receivable
from payments.models import DailyPayment
from ptp.models import DailyPTP
from teams.models import Team

from core.models import AuditLog
from core.serializers import AuditLogSerializer
from core.permissions import IsSuperUser
from rest_framework import filters
from django_filters.rest_framework import DjangoFilterBackend

class DashboardViewSet(viewsets.ViewSet):
    permission_classes = [IsAuthenticated]

    def _get_date(self, request):
        report_date_str = request.query_params.get('date', date.today().strftime('%Y-%m-%d'))
        try:
            return datetime.strptime(report_date_str, '%Y-%m-%d').date()
        except ValueError:
            return None

    def _get_allowed_client_ids(self, user):
        """
        Returns a list of client IDs that the user is allowed to view.
        Returns None if the user can view all clients (superuser).
        Returns empty list if user has no access.
        """
        if user.is_superuser:
            return None
            
        try:
            if hasattr(user, 'analyst'):
                # Regular Admin or Analyst
                # Return IDs of clients assigned to this analyst directly OR via their teams
                direct_client_ids = list(user.analyst.clients.values_list('id', flat=True))
                
                # Get clients from teams where this analyst is a member
                # Team model has 'clients' and 'members' M2M
                team_client_ids = list(Client.objects.filter(teams__members=user.analyst).values_list('id', flat=True))
                
                # Combine unique IDs
                return list(set(direct_client_ids + team_client_ids))
        except Exception as e:
            print(f"Error getting allowed clients: {e}")
            pass
            
        # Default to no access if not superuser and check fails
        return []

    @action(detail=False, methods=['get'])
    def summary(self, request):
        try:
            report_date = self._get_date(request)
            if not report_date:
                return response.Response({"error": "Invalid date format"}, status=400)
            
            client_id = request.query_params.get('client_id')
            analyst_id = request.query_params.get('analyst_id')
            team_id = request.query_params.get('team_id')

            allowed_client_ids = self._get_allowed_client_ids(request.user)
            
            # Restrict Analyst to their own data
            if hasattr(request.user, 'analyst') and request.user.analyst.role == 'ANALYST':
                analyst_id = str(request.user.analyst.id)
            filters = {}
            target_filters = {
                'target_month__year': report_date.year,
                'target_month__month': report_date.month
            }

            # Apply base permission filter
            if allowed_client_ids is not None:
                # If user has specific allowed clients, force filter
                # If they also requested a specific client, verify it's allowed
                if client_id:
                    if client_id.isdigit() and int(client_id) in allowed_client_ids:
                        filters['client_id'] = client_id
                        target_filters['client_id'] = client_id
                    elif not client_id.isdigit():
                        # Text search within allowed clients
                        matching_clients = Client.objects.filter(
                            client_name__icontains=client_id,
                            id__in=allowed_client_ids
                        ).values_list('id', flat=True)
                        
                        if matching_clients:
                            filters['client__in'] = matching_clients
                            target_filters['client__in'] = matching_clients
                        else:
                            filters['client_id'] = -1
                            target_filters['client_id'] = -1
                    else:
                        # Requested ID not in allowed list
                        filters['client_id'] = -1
                        target_filters['client_id'] = -1
                else:
                    # No specific client requested, restrict to all allowed
                    filters['client__in'] = allowed_client_ids
                    target_filters['client__in'] = allowed_client_ids
            else:
                # Superuser - standard filtering
                if client_id:
                    if client_id.isdigit():
                        filters['client_id'] = client_id
                        target_filters['client_id'] = client_id
                    else:
                        matching_clients = Client.objects.filter(client_name__icontains=client_id).values_list('id', flat=True)
                        if matching_clients:
                             filters['client__in'] = matching_clients
                             target_filters['client__in'] = matching_clients
                        else:
                            filters['client_id'] = -1
                            target_filters['client_id'] = -1

            # Analyst filter
            if analyst_id and analyst_id.isdigit():
                 filters['analyst_id'] = analyst_id

            # Team filter
            if team_id and team_id.isdigit():
                 filters['client__teams__id'] = team_id
                 target_filters['client__teams__id'] = team_id

            # Logic for aggregated summary
            pos_total = Receivable.objects.filter(report_date__year=report_date.year, report_date__month=report_date.month, **filters).aggregate(s=Sum('pos_amount'))['s'] or 0
            neg_total = Receivable.objects.filter(report_date__year=report_date.year, report_date__month=report_date.month, **filters).aggregate(s=Sum('neg_amount'))['s'] or 0
    
            payments_today = DailyPayment.objects.filter(payment_date=report_date, **filters).aggregate(s=Sum('amount'))['s'] or 0
            
            month_start = report_date.replace(day=1)
            payments_mtd = DailyPayment.objects.filter(payment_date__gte=month_start, payment_date__lte=report_date, **filters).aggregate(s=Sum('amount'))['s'] or 0
            
            ptp_today = DailyPTP.objects.filter(ptp_date=report_date, **filters).aggregate(s=Sum('ptp_amount'))['s'] or 0
            
            last_day = calendar.monthrange(report_date.year, report_date.month)[1]
            month_end = report_date.replace(day=last_day)
            ptp_total = DailyPTP.objects.filter(ptp_date__gte=month_start, ptp_date__lte=month_end, **filters).aggregate(s=Sum('ptp_amount'))['s'] or 0
            
            # Target
            # Aggregate both targets
            
            # Use aggregated sum by default
            internal_target = 0
            client_target = 0
            
            if analyst_id and analyst_id.isdigit():
                # If filtered by analyst, apply allocation logic
                # Fetch targets relevant to current client/date filters
                targets = Target.objects.filter(**target_filters).select_related('client').prefetch_related('client__analysts')
                
                check_analyst_id = int(analyst_id)
                
                for t in targets:
                    # Check if this analyst is assigned to the client
                    assigned_analysts = t.client.analysts.all()
                    if any(a.id == check_analyst_id for a in assigned_analysts):
                        count = len(assigned_analysts)
                        if count > 0:
                            internal_target += (t.internal_target / count)
                            client_target += (t.client_target / count)
            else:
                # Standard aggregation (Total for selected clients)
                targets_agg = Target.objects.filter(**target_filters).aggregate(
                    internal=Sum('internal_target'),
                    client=Sum('client_target')
                )
                internal_target = targets_agg['internal'] or 0
                client_target = targets_agg['client'] or 0
            
            # Use client_target for achievement calculation as before, or switch to internal if preferred
            # Based on user request to show both, preserving original calculation logic using 'client_target' variable
            # but noting that 'client_target' variable in original code might have been mapped to 'client_target' model field.
            # Let's map explicitly:
            # We will return both. Original 'target' field in response corresponds to 'client_target' generally in this system context?
            # Actually, looking at original code: client_target = Target.objects...aggregate(s=Sum('client_target'))['s']
            # So 'target' in response was 'client_target' from model.
            
            # Use client_target for achievement calculation for now to avoid breaking existing logic logic
            # OR logic: typically internal target is the one we control, but let's stick to returning both and letting frontend decide display.
            
            achievement = (payments_mtd / client_target * 100) if client_target > 0 else 0
            variance = payments_mtd - client_target 

            # Optimized Trend Data: Single query instead of 7
            start_date = report_date - timedelta(days=6)
            trend_payments = DailyPayment.objects.filter(
                payment_date__gte=start_date,
                payment_date__lte=report_date,
                **filters
            ).values('payment_date').annotate(s=Sum('amount'))
            
            trend_map = {x['payment_date']: x['s'] for x in trend_payments}
            
            daily_trend = []
            daily_target = (client_target / last_day) if client_target > 0 else 0
            
            for i in range(6, -1, -1):
                d = report_date - timedelta(days=i)
                day_payments = trend_map.get(d, 0) or 0
                daily_trend.append({
                    "date": d.strftime("%m-%d"),
                    "payments": float(day_payments),
                    "target": float(daily_target)
                })

            data = {
                "pos_amount": pos_total,
                "neg_amount": neg_total,
                "payments_today": payments_today,
                "mtd_payments": payments_mtd,
                "ptp_today": ptp_today,
                "total_ptp": ptp_total,
                "target": client_target, # Keeping for backward compatibility
                "client_target": client_target,
                "internal_target": internal_target,
                "achievement": achievement,
                "variance": variance,
                "grand_total_pos": pos_total, # Alias for frontend
                "grand_total_neg": neg_total,
                "daily_trend": daily_trend,
                "payment_mix": [{"name": "Payments", "value": payments_mtd}, {"name": "PTP", "value": ptp_total}]
            }
            return response.Response(data)
        except Exception as e:
            import traceback
            print(traceback.format_exc())
            return response.Response({"error": str(e), "trace": traceback.format_exc()}, status=500)

    @action(detail=False, methods=['get'])
    def clients(self, request):
        try:
            report_date = self._get_date(request)
            if not report_date: return response.Response({"error": "Invalid date"}, status=400)
            
            # Filter clients logic
            client_query = request.query_params.get('client_id')
            team_id = request.query_params.get('team_id')
            client_filter = {'is_active': True}
            
            allowed_client_ids = self._get_allowed_client_ids(request.user)
            
            # Restrict Analyst to their own data
            current_analyst_id = None
            if hasattr(request.user, 'analyst') and request.user.analyst.role == 'ANALYST':
                current_analyst_id = request.user.analyst.id
            
            if allowed_client_ids is not None:
                 client_filter['id__in'] = allowed_client_ids
            
            if team_id and team_id.isdigit():
                 client_filter['teams__id'] = team_id
            
            if client_query:
                if client_query.isdigit():
                    # Ensure requested ID is allowed if restricted
                    if allowed_client_ids is None or int(client_query) in allowed_client_ids:
                        client_filter['id'] = client_query
                    else:
                        client_filter['id'] = -1 # Not allowed
                else:
                    client_filter['client_name__icontains'] = client_query

            clients = Client.objects.filter(**client_filter)
            
            # Optimize with Maps
            month_start = report_date.replace(day=1)
            
            # Note: We should nominally filter these queries by the allowed clients too for strictness,
            # but since we iterate over the 'clients' list effectively doing a left join in python,
            # we only leak aggregate data if we don't filter.
            # However, for huge datasets, pre-filtering by allowed clients is better for performance.
            
            base_filters = {}
            if allowed_client_ids is not None:
                base_filters['client__in'] = allowed_client_ids
            
            if current_analyst_id:
                base_filters['analyst_id'] = current_analyst_id
                
            pay_mtd = DailyPayment.objects.filter(payment_date__gte=month_start, payment_date__lte=report_date, **base_filters).values('client').annotate(s=Sum('amount'))
            pay_mtd_map = {x['client']: x['s'] for x in pay_mtd}
            
            pay_today = DailyPayment.objects.filter(payment_date=report_date, **base_filters).values('client').annotate(s=Sum('amount'))
            pay_today_map = {x['client']: x['s'] for x in pay_today}
            
            rec = Receivable.objects.filter(report_date__year=report_date.year, report_date__month=report_date.month, **base_filters).values('client').annotate(p=Sum('pos_amount'), n=Sum('neg_amount'), pc=Sum('pos_account_count'), nc=Sum('neg_account_count'))
            rec_map = {x['client']: (x['p'], x['n'], x['pc'], x['nc']) for x in rec}
            
            targets = Target.objects.filter(target_month__year=report_date.year, target_month__month=report_date.month, **base_filters).values('client').annotate(ct=Sum('client_target'), it=Sum('internal_target'))
            tgt_map = {x['client']: (x['ct'], x['it']) for x in targets}
            
            ptp_tot = DailyPTP.objects.filter(ptp_date__gte=month_start, ptp_date__lte=report_date, **base_filters).values('client').annotate(s=Sum('ptp_amount'))
            ptp_map = {x['client']: x['s'] for x in ptp_tot}

            ptp_today_qs = DailyPTP.objects.filter(ptp_date=report_date, **base_filters).values('client').annotate(s=Sum('ptp_amount'))
            ptp_today_map = {x['client']: x['s'] for x in ptp_today_qs}

            data = []
            for c in clients:
                pmtd = pay_mtd_map.get(c.id, 0)
                
                ct, it = tgt_map.get(c.id, (0, 0))
                target = it # Default 'target' is now Internal Target as requested
                
                achieve = (pmtd / target * 100) if target > 0 else 0
                
                pos, neg, pos_count, neg_count = rec_map.get(c.id, (0, 0, 0, 0))
                
                data.append({
                    "id": c.id,
                    "name": c.client_name,
                    "pos_amount": pos,
                    "neg_amount": neg,
                    "pos_count": pos_count,
                    "neg_count": neg_count,
                    "payments_today": pay_today_map.get(c.id, 0),
                    "mtd_payments": pmtd,
                    "target": target, # Internal Target
                    "client_target": ct, # New External Target
                    "achievement": achieve,
                    "variance": pmtd - target,
                    "total_ptp": ptp_map.get(c.id, 0),
                    "ptp_today": ptp_today_map.get(c.id, 0)
                })
                
            return response.Response(data)
        except Exception as e:
            import traceback
            print(traceback.format_exc())
            return response.Response({"error": str(e), "trace": traceback.format_exc()}, status=500)


    @action(detail=False, methods=['get'])
    def analysts(self, request):
        report_date = self._get_date(request)
        if not report_date: return response.Response({"error": "Invalid date"}, status=400)
        
        allowed_client_ids = self._get_allowed_client_ids(request.user)
        base_filters = {}
        if allowed_client_ids is not None:
             base_filters['client__in'] = allowed_client_ids
        
        # Restrict Analyst to their own data
        if hasattr(request.user, 'analyst') and request.user.analyst.role == 'ANALYST':
            base_filters['analyst_id'] = request.user.analyst.id
        
        analyst_filter = {'is_active': True, 'role': 'ANALYST'}
        if allowed_client_ids is not None:
             analyst_filter['clients__id__in'] = allowed_client_ids

        if hasattr(request.user, 'analyst') and request.user.analyst.role == 'ANALYST':
            analyst_filter['id'] = request.user.analyst.id
        
        # Prefetch clients to allow target calculation
        analysts = Analyst.objects.filter(**analyst_filter).prefetch_related('clients').distinct()
        month_start = report_date.replace(day=1)
        
        pay_mtd = DailyPayment.objects.filter(payment_date__gte=month_start, payment_date__lte=report_date, **base_filters).values('analyst').annotate(s=Sum('amount'))
        pay_map = {x['analyst']: x['s'] for x in pay_mtd}
        
        pay_today = DailyPayment.objects.filter(payment_date=report_date, **base_filters).values('analyst').annotate(s=Sum('amount'))
        pay_today_map = {x['analyst']: x['s'] for x in pay_today}
        
        rec = Receivable.objects.filter(report_date__year=report_date.year, report_date__month=report_date.month, **base_filters).values('analyst').annotate(p=Sum('pos_amount'))
        rec_map = {x['analyst']: x['p'] for x in rec}

        # Fetch targets for the month
        targets = Target.objects.filter(target_month__year=report_date.year, target_month__month=report_date.month).values('client', 'internal_target')
        target_map = {x['client']: x['internal_target'] for x in targets}

        data = []
        for a in analysts:
            pmtd = pay_map.get(a.id, 0)
            
            # Calculate target by summing targets of assigned clients
            # Only include clients that are visible to the current user (if restricted)
            analyst_target = 0
            for client in a.clients.all():
                 if allowed_client_ids is None or client.id in allowed_client_ids:
                     c_target = target_map.get(client.id, 0) or 0
                     # Split target among all analysts assigned to this client
                     num_analysts = client.analysts.count()
                     if num_analysts > 0:
                         analyst_target += (c_target / num_analysts)
            
            target = analyst_target
            achieve = (pmtd / target * 100) if target > 0 else 0
            
            data.append({
                "id": a.id,
                "name": a.analyst_name,
                "total_pos_amount": rec_map.get(a.id, 0),
                "payments_today": pay_today_map.get(a.id, 0),
                "mtd_payments": pmtd,
                "target": target,
                "achievement": achieve
            })
            
        return response.Response(data)


class AuditLogViewSet(viewsets.ReadOnlyModelViewSet):
    permission_classes = [IsAuthenticated, IsSuperUser]
    queryset = AuditLog.objects.all()
    serializer_class = AuditLogSerializer
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['action', 'target_model', 'actor__username']
    search_fields = ['details', 'object_id', 'target_model', 'action']
    ordering_fields = ['timestamp']



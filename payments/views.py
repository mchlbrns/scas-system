from rest_framework import viewsets, status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from django.utils.dateparse import parse_date
from .models import DailyPayment
from ptp.models import DailyPTP
from clients.models import Client
from analysts.models import Analyst
from .serializers import DailyPaymentSerializer

class DailyPaymentViewSet(viewsets.ModelViewSet):
    queryset = DailyPayment.objects.all()
    serializer_class = DailyPaymentSerializer
    permission_classes = [IsAuthenticated]
    filterset_fields = ['client', 'analyst', 'payment_date']

    def get_queryset(self):
        user = self.request.user
        queryset = DailyPayment.objects.all()
        
        if user.is_staff:
            return queryset
            
        if hasattr(user, 'analyst'):
             return queryset.filter(analyst=user.analyst)
             
        return queryset

class DailyCollectionEntryView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        client_id = request.query_params.get('client_id')
        date_str = request.query_params.get('date')

        if not client_id or not date_str:
            return Response(
                {"error": "client_id and date are required"}, 
                status=status.HTTP_400_BAD_REQUEST
            )

        try:
            target_date = parse_date(date_str)
            if not target_date:
                raise ValueError
        except ValueError:
            return Response(
                {"error": "Invalid date format"}, 
                status=status.HTTP_400_BAD_REQUEST
            )

        # Get analysts assigned to this client (Role=ANALYST only)
        analysts = Analyst.objects.filter(clients__id=client_id, is_active=True, role='ANALYST')

        # Security check: Ensure user has access to this client
        user = request.user
        if not user.is_superuser:
            if not hasattr(user, 'analyst'):
                return Response({"error": "User has no analyst profile"}, status=status.HTTP_403_FORBIDDEN)
            
            # Check if the requested client is in the user's assigned clients
            if not user.analyst.clients.filter(id=client_id).exists():
                 return Response({"error": "You do not have permission to view this client"}, status=status.HTTP_403_FORBIDDEN)
        
        data = []
        for analyst in analysts:
            # Fetch existing records if any
            payment = DailyPayment.objects.filter(
                client_id=client_id,
                analyst=analyst,
                payment_date=target_date
            ).first()
            
            ptp = DailyPTP.objects.filter(
                client_id=client_id,
                analyst=analyst,
                ptp_date=target_date
            ).first()

            data.append({
                "analyst_id": analyst.id,
                "analyst_name": analyst.analyst_name,
                "payment_amount": payment.amount if payment else 0,
                "ptp_amount": ptp.ptp_amount if ptp else 0,
            })

        return Response(data)

    def post(self, request):
        client_id = request.data.get('client_id')
        date_str = request.data.get('date')
        entries = request.data.get('entries', [])

        if not client_id or not date_str:
            return Response(
                {"error": "client_id and date are required"}, 
                status=status.HTTP_400_BAD_REQUEST
            )

        target_date = parse_date(date_str)
        if not target_date:
             return Response(
                {"error": "Invalid date format"}, 
                status=status.HTTP_400_BAD_REQUEST
            )

        try:
            client = Client.objects.get(id=client_id)
        except Client.DoesNotExist:
            return Response(
                {"error": "Client not found"}, 
                status=status.HTTP_404_NOT_FOUND
            )

        # Security check: Ensure user has access to this client
        user = request.user
        if not user.is_superuser:
            if not hasattr(user, 'analyst'):
                return Response({"error": "User has no analyst profile"}, status=status.HTTP_403_FORBIDDEN)
            
            if not user.analyst.clients.filter(id=client_id).exists():
                 return Response({"error": "You do not have permission to edit this client"}, status=status.HTTP_403_FORBIDDEN)

        # Track changes for audit log
        changes_log = []

        for entry in entries:
            analyst_id = entry.get('analyst_id')
            payment_amount = float(entry.get('payment_amount', 0))
            ptp_amount = float(entry.get('ptp_amount', 0))

            try:
                analyst = Analyst.objects.get(id=analyst_id)
            except Analyst.DoesNotExist:
                continue
            
            # Fetch existing to compare
            existing_payment = DailyPayment.objects.filter(
                client=client, analyst=analyst, payment_date=target_date
            ).first()
            old_payment = float(existing_payment.amount) if existing_payment else 0.0

            existing_ptp = DailyPTP.objects.filter(
                client=client, analyst=analyst, ptp_date=target_date
            ).first()
            old_ptp = float(existing_ptp.ptp_amount) if existing_ptp else 0.0

            # Check if actual changes occurred
            if old_payment != payment_amount or old_ptp != ptp_amount:
                change_record = {
                    'analyst': analyst.analyst_name,
                }
                if old_payment != payment_amount:
                    change_record['payment'] = {'old': old_payment, 'new': payment_amount}
                if old_ptp != ptp_amount:
                    change_record['ptp'] = {'old': old_ptp, 'new': ptp_amount}
                
                changes_log.append(change_record)

                # Update or Create DailyPayment
                DailyPayment.objects.update_or_create(
                    client=client,
                    analyst=analyst,
                    payment_date=target_date,
                    defaults={'amount': payment_amount}
                )

                # Update or Create DailyPTP
                DailyPTP.objects.update_or_create(
                    client=client,
                    analyst=analyst,
                    ptp_date=target_date,
                    defaults={'ptp_amount': ptp_amount}
                )

        # Force audit log action
        if hasattr(request, '_request'):
             request._request._audit_action = 'UPDATED'
             request._request._audit_details = {'entries_changed': changes_log} if changes_log else {'message': 'No changes detected'}
        else:
             request._audit_action = 'UPDATED'
             request._audit_details = {'entries_changed': changes_log} if changes_log else {'message': 'No changes detected'}

        return Response({"status": "success"})

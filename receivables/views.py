from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from .models import Receivable
from .serializers import ReceivableSerializer

class ReceivableViewSet(viewsets.ModelViewSet):
    queryset = Receivable.objects.all()
    serializer_class = ReceivableSerializer
    permission_classes = [IsAuthenticated]
    filterset_fields = ['client', 'analyst', 'report_date']

    def get_queryset(self):
        user = self.request.user
        queryset = Receivable.objects.all()

        if user.is_superuser:
            return queryset

        if hasattr(user, 'analyst'):
            analyst = user.analyst
            # Get clients assigned to this analyst/admin/team lead
            assigned_clients = analyst.clients.all()
            
            # If Admin or Team Leader, allow seeing all receivables for their assigned clients
            if analyst.role in ['ADMIN', 'TEAM_LEADER']:
                 return queryset.filter(client__in=assigned_clients)
            
            # Regular analysts only see their own inputs AND must be for assigned clients
            return queryset.filter(analyst=analyst, client__in=assigned_clients)

        return queryset.none()

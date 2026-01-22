from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from .models import DailyPTP
from .serializers import DailyPTPSerializer

class DailyPTPViewSet(viewsets.ModelViewSet):
    queryset = DailyPTP.objects.all()
    serializer_class = DailyPTPSerializer
    permission_classes = [IsAuthenticated]
    filterset_fields = ['client', 'analyst', 'ptp_date']

    def get_queryset(self):
        user = self.request.user
        queryset = DailyPTP.objects.all()
        
        if user.is_staff:
            return queryset
            
        if hasattr(user, 'analyst'):
             return queryset.filter(analyst=user.analyst)
             
        return queryset

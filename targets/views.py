from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated
from .models import Target
from .serializers import TargetSerializer

class TargetViewSet(viewsets.ModelViewSet):
    queryset = Target.objects.all()
    serializer_class = TargetSerializer
    permission_classes = [IsAuthenticated]
    filterset_fields = ['client', 'target_month']

    def get_queryset(self):
        user = self.request.user
        queryset = Target.objects.all()

        if user.is_superuser:
            return queryset

        if hasattr(user, 'analyst'):
            analyst = user.analyst
            # Restrict to targets for clients assigned to this analyst
            return queryset.filter(client__in=analyst.clients.all())

        return queryset.none()

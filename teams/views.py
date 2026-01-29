from rest_framework import viewsets, permissions, filters
from .models import Team
from .serializers import TeamSerializer

class IsAdminUser(permissions.BasePermission):
    def has_permission(self, request, view):
        if not request.user or not request.user.is_authenticated:
            return False
        if request.user.is_superuser:
            return True
        return hasattr(request.user, 'analyst') and request.user.analyst.role == 'ADMIN'

from core.pagination import StandardResultsSetPagination

class TeamViewSet(viewsets.ModelViewSet):
    queryset = Team.objects.all().order_by('-created_at')
    serializer_class = TeamSerializer
    permission_classes = [IsAdminUser]
    pagination_class = StandardResultsSetPagination
    filter_backends = [filters.SearchFilter]
    search_fields = ['name', 'description']

    def get_queryset(self):
        queryset = super().get_queryset()
        user = self.request.user

        # Filter by logged-in user if not superuser
        if not user.is_superuser and user.username.lower() != 'admin':
            if hasattr(user, 'analyst'):
                # Get clients assigned to this analyst/admin
                assigned_clients = user.analyst.clients.all()
                # Filter teams that handle at least one of these clients
                queryset = queryset.filter(clients__in=assigned_clients).distinct()
            else:
                return Team.objects.none()

        status = self.request.query_params.get('status')
        if status:
            is_active = status.upper() == 'ACTIVE'
            queryset = queryset.filter(is_active=is_active)
        return queryset

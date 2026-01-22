from rest_framework import viewsets, permissions, filters
from .models import Client
from .serializers import ClientSerializer

class IsAdminUserOrReadOnly(permissions.BasePermission):
    def has_permission(self, request, view):
        if request.method in permissions.SAFE_METHODS:
            return request.user and request.user.is_authenticated
            
        if not request.user or not request.user.is_authenticated:
            return False
            
        if request.user.is_superuser:
            return True

        return hasattr(request.user, 'analyst') and request.user.analyst.role == 'ADMIN'

class ClientViewSet(viewsets.ModelViewSet):
    queryset = Client.objects.all().order_by('-created_at')
    serializer_class = ClientSerializer
    permission_classes = [IsAdminUserOrReadOnly]
    filter_backends = [filters.SearchFilter]
    search_fields = ['client_name', 'client_code']

    def get_queryset(self):
        queryset = super().get_queryset()
        user = self.request.user

        # Filter by logged-in user if not superuser
        if not user.is_superuser:
            if hasattr(user, 'analyst'):
                queryset = queryset.filter(analysts=user.analyst)
            else:
                return Client.objects.none()

        status = self.request.query_params.get('status')
        if status:
            is_active = status.upper() == 'ACTIVE'
            queryset = queryset.filter(is_active=is_active)
        return queryset

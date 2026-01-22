from rest_framework import viewsets, permissions, filters
from .models import Analyst
from .serializers import AnalystSerializer

class IsAdminUser(permissions.BasePermission):
    def has_permission(self, request, view):
        # Allow read-only for authentication checks or basic listings if needed, 
        # but spec says ADMIN only for this module. 
        # For dashboard filters (read-only), we might need to relax this or create a separate read-only view.
        # Spec says: "Integration With Existing Filters... powered by GET /api/analysts".
        # So GET should be allowed for authenticated users (Analysts accessing dashboard).
        # CUD should be ADMIN only.
        
        if request.method in permissions.SAFE_METHODS:
            return request.user and request.user.is_authenticated
            
        if not request.user or not request.user.is_authenticated:
            return False
            
        if request.user.is_superuser:
            return True
            
        return hasattr(request.user, 'analyst') and request.user.analyst.role == 'ADMIN'

class AnalystViewSet(viewsets.ModelViewSet):
    queryset = Analyst.objects.all().order_by('-created_at')
    serializer_class = AnalystSerializer
    permission_classes = [IsAdminUser]
    filter_backends = [filters.SearchFilter]
    search_fields = ['analyst_name', 'email', 'user__username']

    def get_queryset(self):
        queryset = super().get_queryset()
        user = self.request.user

        # Filter by logged-in user if not superuser
        if not user.is_superuser:
            if hasattr(user, 'analyst'):
                # Get clients assigned to this analyst/admin
                assigned_clients = user.analyst.clients.all()
                # Filter analysts/users who work on at least one of these clients
                queryset = queryset.filter(clients__in=assigned_clients).distinct()
            else:
                return Analyst.objects.none()

        status = self.request.query_params.get('status')
        if status:
            is_active = status.upper() == 'ACTIVE'
            queryset = queryset.filter(is_active=is_active)
        
        role = self.request.query_params.get('role')
        if role:
            queryset = queryset.filter(role=role)
            
        return queryset

    def perform_create(self, serializer):
        user = self.request.user
        extra_data = {}

        # If restricted admin (analyst) creates a user and assigns no clients, 
        # auto-assign the admin's clients so the new user is visible.
        if not user.is_superuser and hasattr(user, 'analyst'):
            # Check if clients are already being assigned in the request
            # note: 'clients' key comes from source='clients' in serializer
            assigned_clients = serializer.validated_data.get('clients', [])
            
            if not assigned_clients:
                creator_clients = user.analyst.clients.all()
                if creator_clients.exists():
                     # Pass as list or queryset to match what serializer expects
                     extra_data['clients'] = list(creator_clients)
        
        serializer.save(**extra_data)

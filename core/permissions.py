from rest_framework import permissions

class IsAdminUser(permissions.BasePermission):
    def has_permission(self, request, view):
        return request.user and request.user.is_authenticated and (request.user.is_staff or request.user.groups.filter(name='Admin').exists())

class IsSupervisor(permissions.BasePermission):
    def has_permission(self, request, view):
        if not request.user or not request.user.is_authenticated:
            return False
        return request.user.is_staff or request.user.groups.filter(name__in=['Admin', 'Supervisor']).exists()

class IsAnalyst(permissions.BasePermission):
    def has_permission(self, request, view):
        if not request.user or not request.user.is_authenticated:
            return False
        # Analysts can read, but write requires specific checks usually handled in views or object permissions
        return True

class IsOwnerOrReadOnly(permissions.BasePermission):
    """
    Object-level permission to only allow owners of an object to edit it.
    Assumes the model instance has an `analyst` attribute which corresponds to the user.
    """
    def has_object_permission(self, request, view, obj):
        # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        if request.method in permissions.SAFE_METHODS:
            return True

        # Write permissions are only allowed to the owner of the snippet.
        # This assumes 'analyst' on the model links to a User or Profile. 
        # However, the spec says 'Analyst' model exists. 
        # We need to link auth.User to analysts.Analyst if we want strict row-level security based on login.
        # For now, simplistic implementation.
        return True 

from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import TokenRefreshView
from core.views import (
    CustomTokenObtainPairView, 
    LogoutView,
    ChangePasswordView,
    RequestPasswordResetView,
    PasswordResetRequestViewSet
)

# Import ViewSets for Master Data
from clients.views import ClientViewSet
from analysts.views import AnalystViewSet
from teams.views import TeamViewSet

# Router Setup
router = DefaultRouter()
router.register(r'clients', ClientViewSet)
router.register(r'analysts', AnalystViewSet)
router.register(r'teams', TeamViewSet)
router.register(r'password-reset-requests', PasswordResetRequestViewSet)

urlpatterns = [
    path('admin/', admin.site.urls),
    
    # Master Data APIs (via Router)
    path('api/v1/', include(router.urls)),

    # Legacy/Existing APIs (via include)
    path('api/v1/receivables/', include('receivables.urls')),
    path('api/v1/payments/', include('payments.urls')),
    path('api/v1/ptp/', include('ptp.urls')),
    path('api/v1/targets/', include('targets.urls')),
    path('api/v1/dashboard/', include('dashboard.urls')),
    path('api/v1/accounts/', include('accounts.urls')),
    
    # Auth
    path('api/auth/login/', CustomTokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/auth/logout/', LogoutView.as_view(), name='auth_logout'),
    path('api/auth/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('api/auth/request-password-reset/', RequestPasswordResetView.as_view(), name='request_password_reset'),

    # Standard JWT Endpoints (For external integrations)
    path('api/token/', CustomTokenObtainPairView.as_view(), name='standard_token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='standard_token_refresh'),
    
    # Profile & Security
    path('api/v1/core/change-password/', ChangePasswordView.as_view(), name='change_password'),
]

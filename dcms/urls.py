from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import TokenRefreshView
from core.views import CustomTokenObtainPairView

# Import ViewSets for Master Data
from clients.views import ClientViewSet
from analysts.views import AnalystViewSet
from teams.views import TeamViewSet

# Router Setup
router = DefaultRouter()
router.register(r'clients', ClientViewSet)
router.register(r'analysts', AnalystViewSet)
router.register(r'teams', TeamViewSet)

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
    
    # Auth
    path('api/auth/login/', CustomTokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/auth/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]

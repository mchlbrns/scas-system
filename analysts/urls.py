from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import AnalystViewSet

router = DefaultRouter()
router.register(r'', AnalystViewSet)

urlpatterns = [
    path('', include(router.urls)),
]

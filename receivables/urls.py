from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ReceivableViewSet

router = DefaultRouter()
router.register(r'', ReceivableViewSet)

urlpatterns = [
    path('', include(router.urls)),
]

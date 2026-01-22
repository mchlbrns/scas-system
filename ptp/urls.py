from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import DailyPTPViewSet

router = DefaultRouter()
router.register(r'', DailyPTPViewSet)

urlpatterns = [
    path('', include(router.urls)),
]

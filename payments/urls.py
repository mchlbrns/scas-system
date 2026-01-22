from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import DailyPaymentViewSet, DailyCollectionEntryView

router = DefaultRouter()
router.register(r'', DailyPaymentViewSet)

urlpatterns = [
    path('daily-entry/', DailyCollectionEntryView.as_view(), name='daily-collection-entry'),
    path('', include(router.urls)),
]

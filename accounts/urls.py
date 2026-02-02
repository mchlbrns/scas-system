from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import AccountViewSet, ImportSchemaViewSet, ImportBatchViewSet, ActivityLogViewSet, AccountPTPViewSet

router = DefaultRouter()
router.register(r'accounts', AccountViewSet)
router.register(r'import-schemas', ImportSchemaViewSet)
router.register(r'import-batches', ImportBatchViewSet)
router.register(r'activity-logs', ActivityLogViewSet)
router.register(r'account-ptps', AccountPTPViewSet)

urlpatterns = [
    path('', include(router.urls)),
]

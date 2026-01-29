from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import AccountViewSet, ImportSchemaViewSet

router = DefaultRouter()
router.register(r'accounts', AccountViewSet)
router.register(r'import-schemas', ImportSchemaViewSet)

urlpatterns = [
    path('', include(router.urls)),
]

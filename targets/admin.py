from django.contrib import admin
from .models import Target

@admin.register(Target)
class TargetAdmin(admin.ModelAdmin):
    list_display = ('client', 'target_month', 'client_target', 'internal_target')
    list_filter = ('target_month', 'client')

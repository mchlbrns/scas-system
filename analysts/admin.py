from django.contrib import admin
from .models import Analyst

@admin.register(Analyst)
class AnalystAdmin(admin.ModelAdmin):
    list_display = ('analyst_name', 'is_active', 'created_at')
    search_fields = ('analyst_name',)
    list_filter = ('is_active',)

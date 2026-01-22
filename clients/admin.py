from django.contrib import admin
from .models import Client

@admin.register(Client)
class ClientAdmin(admin.ModelAdmin):
    list_display = ('client_name', 'is_active', 'created_at')
    search_fields = ('client_name',)
    list_filter = ('is_active',)

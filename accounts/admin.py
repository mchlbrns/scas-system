from django.contrib import admin
from .models import Account, ImportSchema, ImportBatch, ActivityLog

@admin.register(Account)
class AccountAdmin(admin.ModelAdmin):
    list_display = ('account_number', 'client', 'outstanding_balance', 'status')
    search_fields = ('account_number', 'account_name')
    list_filter = ('client', 'status')

@admin.register(ImportSchema)
class ImportSchemaAdmin(admin.ModelAdmin):
    list_display = ('name', 'client', 'is_active')
    list_filter = ('client',)

@admin.register(ImportBatch)
class ImportBatchAdmin(admin.ModelAdmin):
    list_display = ('filename', 'client', 'uploaded_at', 'record_count')

@admin.register(ActivityLog)
class ActivityLogAdmin(admin.ModelAdmin):
    list_display = ('account', 'action', 'outcome', 'created_by', 'created_at')


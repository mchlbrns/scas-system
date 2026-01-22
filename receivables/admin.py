from django.contrib import admin
from .models import Receivable

@admin.register(Receivable)
class ReceivableAdmin(admin.ModelAdmin):
    list_display = ('report_date', 'client', 'analyst', 'pos_amount', 'neg_amount')
    list_filter = ('report_date', 'client', 'analyst')
    date_hierarchy = 'report_date'

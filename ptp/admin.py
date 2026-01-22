from django.contrib import admin
from .models import DailyPTP

@admin.register(DailyPTP)
class DailyPTPAdmin(admin.ModelAdmin):
    list_display = ('ptp_date', 'client', 'analyst', 'ptp_amount')
    list_filter = ('ptp_date', 'client', 'analyst')
    date_hierarchy = 'ptp_date'

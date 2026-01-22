from django.contrib import admin
from .models import DailyPayment

@admin.register(DailyPayment)
class DailyPaymentAdmin(admin.ModelAdmin):
    list_display = ('payment_date', 'client', 'analyst', 'amount')
    list_filter = ('payment_date', 'client', 'analyst')
    date_hierarchy = 'payment_date'

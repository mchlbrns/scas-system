from django.db import models
from clients.models import Client
from analysts.models import Analyst

class Account(models.Model):
    STATUS_CHOICES = [
        ('NEW', 'New'),
        ('ASSIGNED', 'Assigned'),
        ('RETURNED', 'Returned'),
        ('PAID', 'Paid'),
        ('CLOSED', 'Closed'),
    ]

    client = models.ForeignKey(Client, on_delete=models.CASCADE, related_name='accounts')
    account_number = models.CharField(max_length=100, db_index=True)
    account_name = models.CharField(max_length=255)
    endorsement_date = models.DateField()
    recall_date = models.DateField(null=True, blank=True)
    outstanding_balance = models.DecimalField(max_digits=15, decimal_places=2)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='NEW')
    assigned_analyst = models.ForeignKey(Analyst, on_delete=models.SET_NULL, null=True, blank=True, related_name='assigned_accounts')
    
    # Flexible field for extra CSV columns (Address, Contact No, handling variances)
    data_payload = models.JSONField(default=dict, blank=True)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        unique_together = ('client', 'account_number')
        ordering = ['-endorsement_date']

    def __str__(self):
        return f"{self.account_number} - {self.account_name}"

class ImportSchema(models.Model):
    client = models.ForeignKey(Client, on_delete=models.CASCADE, related_name='import_schemas')
    name = models.CharField(max_length=100)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('client', 'name')

    def __str__(self):
        return f"{self.client.client_code} - {self.name}"

class ColumnMapping(models.Model):
    TARGET_FIELD_CHOICES = [
        ('account_number', 'Account Number'),
        ('account_name', 'Account Name'),
        ('endorsement_date', 'Endorsement Date'),
        ('recall_date', 'Recall Date'),
        ('outstanding_balance', 'Outstanding Balance'),
        ('data_payload', 'Extra Data (JSON)'),
    ]

    DATA_TYPE_CHOICES = [
        ('STRING', 'String'),
        ('DECIMAL', 'Decimal'),
        ('DATE', 'Date'),
    ]

    schema = models.ForeignKey(ImportSchema, on_delete=models.CASCADE, related_name='column_mappings')
    csv_header = models.CharField(max_length=255)
    target_field = models.CharField(max_length=50, choices=TARGET_FIELD_CHOICES)
    data_type = models.CharField(max_length=20, choices=DATA_TYPE_CHOICES, default='STRING')
    is_required = models.BooleanField(default=False)
    default_value = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        unique_together = ('schema', 'csv_header')

    def __str__(self):
        return f"{self.csv_header} -> {self.target_field}"

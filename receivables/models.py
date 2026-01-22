from django.db import models
from clients.models import Client
from analysts.models import Analyst

class Receivable(models.Model):
    client = models.ForeignKey(Client, on_delete=models.CASCADE)
    analyst = models.ForeignKey(Analyst, on_delete=models.CASCADE)
    report_date = models.DateField()
    pos_account_count = models.IntegerField(default=0)
    pos_amount = models.DecimalField(max_digits=15, decimal_places=2, default=0)
    neg_account_count = models.IntegerField(default=0)
    neg_amount = models.DecimalField(max_digits=15, decimal_places=2, default=0)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('client', 'analyst', 'report_date')

    def __str__(self):
        return f"{self.report_date} - {self.client} - {self.analyst}"

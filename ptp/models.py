from django.db import models
from clients.models import Client
from analysts.models import Analyst

class DailyPTP(models.Model):
    client = models.ForeignKey(Client, on_delete=models.CASCADE)
    analyst = models.ForeignKey(Analyst, on_delete=models.CASCADE)
    ptp_date = models.DateField()
    ptp_amount = models.DecimalField(max_digits=15, decimal_places=2)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('client', 'analyst', 'ptp_date')

    def __str__(self):
        return f"{self.ptp_date} - {self.ptp_amount}"

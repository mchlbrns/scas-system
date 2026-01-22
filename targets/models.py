from django.db import models
from clients.models import Client

class Target(models.Model):
    client = models.ForeignKey(Client, on_delete=models.CASCADE)
    target_month = models.DateField()
    internal_target = models.DecimalField(max_digits=15, decimal_places=2)
    client_target = models.DecimalField(max_digits=15, decimal_places=2)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('client', 'target_month')

    def __str__(self):
        return f"{self.client} - {self.target_month}"

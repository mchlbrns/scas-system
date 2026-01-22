from django.db import models
from django.contrib.auth.models import User
from clients.models import Client

class Analyst(models.Model):
    ROLE_CHOICES = [
        ('ADMIN', 'Admin'),
        ('ANALYST', 'Analyst'),
        ('TEAM_LEADER', 'Team Leader'),
    ]

    user = models.OneToOneField(User, on_delete=models.SET_NULL, null=True, blank=True)
    analyst_name = models.CharField(max_length=100)
    role = models.CharField(max_length=20, choices=ROLE_CHOICES, default='ANALYST')
    email = models.EmailField(unique=True, null=True, blank=True)
    clients = models.ManyToManyField(Client, related_name='analysts', blank=True)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.analyst_name} ({self.get_role_display()})"

from django.db import models
from analysts.models import Analyst
from clients.models import Client

class Team(models.Model):
    name = models.CharField(max_length=100, unique=True)
    description = models.TextField(null=True, blank=True)
    team_lead = models.ForeignKey(Analyst, on_delete=models.SET_NULL, null=True, blank=True, related_name='led_teams')
    members = models.ManyToManyField(Analyst, related_name='teams', blank=True)
    clients = models.ManyToManyField(Client, related_name='teams', blank=True)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

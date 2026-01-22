from rest_framework import serializers
from .models import Client
from teams.models import Team
from analysts.models import Analyst

class SimpleTeamSerializer(serializers.ModelSerializer):
    class Meta:
        model = Team
        fields = ['id', 'name']

class SimpleAnalystSerializer(serializers.ModelSerializer):
    class Meta:
        model = Analyst
        fields = ['id', 'analyst_name', 'role']

class ClientSerializer(serializers.ModelSerializer):
    teams = SimpleTeamSerializer(many=True, read_only=True)
    analysts = SimpleAnalystSerializer(many=True, read_only=True)

    class Meta:
        model = Client
        fields = ['id', 'client_code', 'client_name', 'email', 'contact_person', 'remarks', 'is_active', 'created_at', 'updated_at', 'teams', 'analysts']

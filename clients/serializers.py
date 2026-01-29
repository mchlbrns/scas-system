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

    def validate_client_name(self, value):
        """
        Normalize client name by stripping whitespace and ensuring it's not empty.
        Validation for uniqueness is handled by the model's unique=True constraint,
        but we want to catch 'Client A' vs 'Client A ' issues here.
        """
        if value:
            value = value.strip()
        
        # Check if a client with this name already exists (case-insensitive check for better UX)
        if Client.objects.filter(client_name__iexact=value).exists():
             # If we are updating an existing instance, exclude it from the check
            if self.instance and self.instance.client_name.lower() == value.lower():
                pass
            else:
                raise serializers.ValidationError(f"Client with name '{value}' already exists.")
        
        return value

    class Meta:
        model = Client
        fields = ['id', 'client_code', 'client_name', 'email', 'contact_person', 'remarks', 'is_active', 'created_at', 'updated_at', 'teams', 'analysts']

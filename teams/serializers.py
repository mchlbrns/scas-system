from rest_framework import serializers
from .models import Team
from analysts.serializers import AnalystSerializer
from clients.serializers import ClientSerializer
from clients.models import Client

class TeamSerializer(serializers.ModelSerializer):
    members = AnalystSerializer(many=True, read_only=True)
    member_ids = serializers.PrimaryKeyRelatedField(
        many=True, write_only=True, queryset=Team.members.field.related_model.objects.all(), source='members'
    )
    member_ids = serializers.PrimaryKeyRelatedField(
        many=True, write_only=True, queryset=Team.members.field.related_model.objects.all(), source='members'
    )
    clients = ClientSerializer(many=True, read_only=True)
    client_ids = serializers.PrimaryKeyRelatedField(
        many=True, write_only=True, queryset=Client.objects.all(), source='clients'
    )
    team_lead_details = AnalystSerializer(source='team_lead', read_only=True)

    class Meta:
        model = Team
        fields = ['id', 'name', 'description', 'team_lead', 'team_lead_details', 'members', 'member_ids', 'clients', 'client_ids', 'is_active', 'created_at', 'updated_at']

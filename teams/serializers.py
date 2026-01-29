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

    def validate_member_ids(self, value):
        # Allow checking against current instance for updates
        current_team_id = self.instance.id if self.instance else None
        
        for analyst in value:
            # Check if analyst is in any team other than this one
            existing_teams = analyst.teams.exclude(id=current_team_id) if current_team_id else analyst.teams.all()
            if existing_teams.exists():
                other_team = existing_teams.first()
                raise serializers.ValidationError(
                    f"Analyst {analyst.analyst_name} is already assigned to team '{other_team.name}'. "
                    "Please remove them from that team first."
                )
        return value

    def validate_client_ids(self, value):
        current_team_id = self.instance.id if self.instance else None
        
        for client in value:
            existing_teams = client.teams.exclude(id=current_team_id) if current_team_id else client.teams.all()
            if existing_teams.exists():
                other_team = existing_teams.first()
                raise serializers.ValidationError(
                    f"Client {client.client_name} is already assigned to team '{other_team.name}'. "
                    "Please remove them from that team first."
                )
        return value

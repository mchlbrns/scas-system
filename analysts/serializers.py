from rest_framework import serializers
from .models import Analyst
from django.contrib.auth.models import User
from clients.serializers import ClientSerializer
from clients.models import Client

from teams.models import Team

class SimpleTeamSerializer(serializers.ModelSerializer):
    class Meta:
        model = Team
        fields = ['id', 'name']

class AnalystSerializer(serializers.ModelSerializer):
    role_display = serializers.CharField(source='get_role_display', read_only=True)
    username = serializers.CharField(source='user.username', read_only=True)
    
    # Write-only fields for credentials
    custom_username = serializers.CharField(write_only=True, required=False, allow_blank=True)
    password = serializers.CharField(write_only=True, required=False, allow_blank=True)
    
    clients = ClientSerializer(many=True, read_only=True)
    client_ids = serializers.PrimaryKeyRelatedField(
        many=True, write_only=True, queryset=Client.objects.all(), source='clients', required=False
    )
    teams = SimpleTeamSerializer(many=True, read_only=True)
    
    class Meta:
        model = Analyst
        fields = ['id', 'user', 'username', 'custom_username', 'password', 'analyst_name', 'role', 'role_display', 'email', 'clients', 'client_ids', 'teams', 'is_active', 'created_at', 'updated_at']
        read_only_fields = ['user']

    def validate_analyst_name(self, value):
        if value:
            return value.title()
        return value

    def create(self, validated_data):
        email = validated_data.get('email')
        analyst_name = validated_data.get('analyst_name')
        
        # Extract custom credentials
        provided_username = validated_data.pop('custom_username', None)
        provided_password = validated_data.pop('password', None)
        
        # Extract M2M clients
        clients = validated_data.pop('clients', [])
        
        # Determine username
        if provided_username:
            username = provided_username
            if User.objects.filter(username=username).exists():
                 raise serializers.ValidationError({"custom_username": "Username already exists."})
        else:
            username = email.split('@')[0] if email else analyst_name.replace(' ', '').lower()
            # Ensure unique username if auto-generated
            base_username = username
            counter = 1
            while User.objects.filter(username=username).exists():
                username = f"{base_username}{counter}"
                counter += 1

        # Determine password
        password = provided_password if provided_password else 'Password123!'

        # Create User
        user = User.objects.create_user(
            username=username,
            email=email,
            password=password, 
            first_name=analyst_name.split(' ')[0] if ' ' in analyst_name else analyst_name,
            last_name=' '.join(analyst_name.split(' ')[1:]) if ' ' in analyst_name else ''
        )
        
        # Sync is_active status
        if 'is_active' in validated_data:
            user.is_active = validated_data['is_active']
            user.save()
        
        # Create Analyst
        analyst = Analyst.objects.create(user=user, **validated_data)
        
        # Set M2M clients
        if clients:
            analyst.clients.set(clients)
            
        return analyst

    def update(self, instance, validated_data):
        # Update associated user email if analyst email changes
        email = validated_data.get('email')
        if email and instance.user and instance.user.email != email:
            instance.user.email = email
            instance.user.save()

        # Update associated user status
        is_active = validated_data.get('is_active')
        if is_active is not None and instance.user:
            instance.user.is_active = is_active
            instance.user.save()
            
        return super().update(instance, validated_data)

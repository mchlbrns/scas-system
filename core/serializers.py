from rest_framework import serializers
from rest_framework.exceptions import AuthenticationFailed
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from analysts.models import Analyst

class CustomTokenObtainPairSerializer(TokenObtainPairSerializer):
    def validate(self, attrs):
        data = super().validate(attrs)
        
        # Check Analyst status explicitly
        user = self.user
        analyst = getattr(user, 'analyst', None)
        
        if analyst:
            if not analyst.is_active:
                raise AuthenticationFailed("User account is inactive.")
            role = analyst.role
        else:
            role = 'ADMIN' if user.is_superuser else 'ANALYST'

        # Add custom user data to response
        data['user'] = {
            'id': user.id,
            'name': user.username,
            'email': user.email,
            'role': role,
            'is_superuser': user.is_superuser,
            'must_change_password': user.profile.must_change_password if hasattr(user, 'profile') else False,
        }
        
        # Map 'access' to 'token' for frontend compatibility
        data['token'] = data['access']
        data['refresh'] = data['refresh']
        
        return data

from django.contrib.auth.password_validation import validate_password

class ChangePasswordSerializer(serializers.Serializer):
    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True, min_length=8)

    def validate_old_password(self, value):
        user = self.context['request'].user
        if not user.check_password(value):
            raise serializers.ValidationError("Old password is not correct")
        return value

    def validate(self, attrs):
        if attrs['old_password'] == attrs['new_password']:
            raise serializers.ValidationError({"new_password": "New password must be different from old password"})
        
        user = self.context['request'].user
        try:
            validate_password(attrs['new_password'], user=user)
        except Exception as e:
             raise serializers.ValidationError({"new_password": list(e.messages)})
        
        return attrs

from .models import PasswordResetRequest

class PasswordResetRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = PasswordResetRequest
        fields = ['id', 'username', 'user', 'status', 'created_at', 'updated_at']

from .models import AuditLog

class AuditLogSerializer(serializers.ModelSerializer):
    actor_name = serializers.ReadOnlyField(source='actor.username')
    
    class Meta:
        model = AuditLog
        fields = '__all__'

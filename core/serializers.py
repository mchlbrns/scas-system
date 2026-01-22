from rest_framework import serializers
from rest_framework.exceptions import AuthenticationFailed
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
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
        }
        
        # Map 'access' to 'token' for frontend compatibility
        # Map 'access' to 'token' for frontend compatibility
        data['token'] = data['access']
        data['refresh'] = data['refresh']
        
        return data

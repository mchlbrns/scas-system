from rest_framework import generics, status, viewsets
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny, IsAdminUser
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework.decorators import action
from django.contrib.auth.models import User
from django.core.mail import send_mail
import secrets
import string

from .models import PasswordResetRequest, Profile, AuditLog
from .serializers import (
    CustomTokenObtainPairSerializer, 
    ChangePasswordSerializer,
    PasswordResetRequestSerializer
)

class CustomTokenObtainPairView(TokenObtainPairView):
    serializer_class = CustomTokenObtainPairSerializer

    def post(self, request, *args, **kwargs):
        response = super().post(request, *args, **kwargs)
        
        if response.status_code == 200:
            # Login successful
            username = request.data.get('username')
            user = User.objects.filter(username=username).first()
            
            # Get Client IP
            x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
            if x_forwarded_for:
                ip = x_forwarded_for.split(',')[0]
            else:
                ip = request.META.get('REMOTE_ADDR')

            AuditLog.objects.create(
                actor=user,
                action='LOGIN',
                target_model='User',
                object_id=str(user.id) if user else None,
                details={'message': 'User logged in successfully'},
                ip_address=ip
            )
            
        return response

class LogoutView(generics.GenericAPIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        user = request.user
        
        # Get Client IP
        x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
        if x_forwarded_for:
            ip = x_forwarded_for.split(',')[0]
        else:
            ip = request.META.get('REMOTE_ADDR')
            
        AuditLog.objects.create(
            actor=user,
            action='LOGOUT',
            target_model='User',
            object_id=str(user.id),
            details={'message': 'User logged out successfully'},
            ip_address=ip
        )
        
        return Response({"detail": "Successfully logged out."}, status=status.HTTP_200_OK)

class ChangePasswordView(generics.UpdateAPIView):
    serializer_class = ChangePasswordSerializer
    permission_classes = [IsAuthenticated]

    def get_object(self):
        return self.request.user

    def update(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        # Set new password
        user = self.request.user
        user.set_password(serializer.validated_data['new_password'])
        
        # Reset force change flag if it was set
        if hasattr(user, 'profile') and user.profile.must_change_password:
            user.profile.must_change_password = False
            user.profile.save()
            
        user.save()
        
        return Response({"detail": "Password updated successfully"}, status=status.HTTP_200_OK)

    def post(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)

class RequestPasswordResetView(generics.CreateAPIView):
    permission_classes = [AllowAny]
    serializer_class = PasswordResetRequestSerializer

    def post(self, request, *args, **kwargs):
        username = request.data.get('username')
        if not username:
            return Response({"error": "Username is required"}, status=status.HTTP_400_BAD_REQUEST)
        
        user_matches = User.objects.filter(username=username).first()
        
        PasswordResetRequest.objects.create(
            username=username,
            user=user_matches,
            status='PENDING'
        )
        return Response({"detail": "Password reset request has been submitted to administrators."}, status=status.HTTP_201_CREATED)

class PasswordResetRequestViewSet(viewsets.ReadOnlyModelViewSet):
    permission_classes = [IsAdminUser]
    queryset = PasswordResetRequest.objects.all().order_by('-created_at')
    serializer_class = PasswordResetRequestSerializer

    @action(detail=True, methods=['post'])
    def approve(self, request, pk=None):
        reset_req = self.get_object()
        if reset_req.status != 'PENDING':
             return Response({"error": "Request already processed"}, status=status.HTTP_400_BAD_REQUEST)
        
        user = reset_req.user
        if not user:
             # Try to find user again by username just in case
             user = User.objects.filter(username=reset_req.username).first()
             if not user:
                return Response({"error": "No associated user found for this username"}, status=status.HTTP_400_BAD_REQUEST)
        
        # Generate temp password
        alphabet = string.ascii_letters + string.digits
        temp_password = ''.join(secrets.choice(alphabet) for i in range(12))
        
        user.set_password(temp_password)
        
        # Ensure profile and set flag
        if not hasattr(user, 'profile'):
             Profile.objects.create(user=user)
        user.profile.must_change_password = True
        user.profile.save()
        user.save()
        
        reset_req.status = 'APPROVED'
        reset_req.save()
        
        return Response({
            "detail": "Request approved.",
            "temp_password": temp_password
        }, status=status.HTTP_200_OK)

    @action(detail=True, methods=['post'])
    def deny(self, request, pk=None):
        reset_req = self.get_object()
        if reset_req.status != 'PENDING':
            return Response({"error": "Request already processed"}, status=status.HTTP_400_BAD_REQUEST)

        reset_req.status = 'REJECTED'
        reset_req.save()
        return Response({"detail": "Request rejected."}, status=status.HTTP_200_OK)

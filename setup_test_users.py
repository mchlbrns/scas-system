
import os
import django
from django.contrib.auth import get_user_model

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dcms.settings')
django.setup()

from analysts.models import Analyst
from clients.models import Client

User = get_user_model()

def create_user(username, password, is_superuser=False):
    try:
        user = User.objects.get(username=username)
        user.set_password(password)
        user.is_superuser = is_superuser
        user.is_staff = is_superuser
        user.save()
        print(f"User {username} updated.")
    except User.DoesNotExist:
        user = User.objects.create_user(username=username, password=password)
        user.is_superuser = is_superuser
        user.is_staff = is_superuser
        user.save()
        print(f"User {username} created.")
    return user

def setup_analyst(user, role, client_id):
    try:
        analyst = Analyst.objects.get(user=user)
        analyst.role = role
        analyst.save()
        print(f"Analyst {user.username} updated.")
    except Analyst.DoesNotExist:
        analyst = Analyst.objects.create(user=user, analyst_name=user.username, role=role)
        print(f"Analyst {user.username} created.")
    
    # Assign client
    if client_id:
        client = Client.objects.get(id=client_id)
        analyst.clients.add(client)
        print(f"Assigned client {client.client_name} to {user.username}")

# 1. Admin
admin_user = create_user('test_admin', 'password123', is_superuser=True)
# Ensure admin has an Analyst profile too if needed by the system (often systems requiring 'profile' need this)
setup_analyst(admin_user, 'ADMIN', None)

# 2. Analyst
analyst_user = create_user('test_analyst', 'password123', is_superuser=False)
setup_analyst(analyst_user, 'ANALYST', 10) # Assign ACOM OD (10)

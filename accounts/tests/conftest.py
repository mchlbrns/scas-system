import pytest
from rest_framework.test import APIClient
from clients.models import Client
from django.contrib.auth.models import User

@pytest.fixture
def api_client():
    return APIClient()

@pytest.fixture
def client_data():
    return Client.objects.create(client_name="Test Client", client_code="TEST01")

@pytest.fixture
def user():
    return User.objects.create_user(username='testuser', password='password')

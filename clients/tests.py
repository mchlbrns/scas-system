from django.test import TestCase
from django.db.utils import IntegrityError
from rest_framework.exceptions import ValidationError as DRFValidationError
from clients.models import Client
from clients.serializers import ClientSerializer

class ClientDuplicationTest(TestCase):
    def setUp(self):
        self.client_name = "Test Client"
        self.client = Client.objects.create(client_name=self.client_name, client_code="TC001")

    def test_model_duplicate_creation_fails(self):
        """Test that creating a client with the same name at DB level raises IntegrityError"""
        with self.assertRaises(IntegrityError):
            Client.objects.create(client_name=self.client_name, client_code="TC002")

    def test_serializer_normalization(self):
        """Test that serializer trims whitespace"""
        data = {
            "client_name": "  New Client  ",
            "client_code": "NC001"
        }
        serializer = ClientSerializer(data=data)
        self.assertTrue(serializer.is_valid())
        self.assertEqual(serializer.validated_data['client_name'], "New Client")

    def test_serializer_duplicate_validation(self):
        """Test that serializer catches exact duplicates"""
        data = {
            "client_name": "Test Client",
            "client_code": "TC002"
        }
        serializer = ClientSerializer(data=data)
        self.assertFalse(serializer.is_valid())
        self.assertIn("client_name", serializer.errors)
        self.assertIn("already exists", str(serializer.errors['client_name'][0]))

    def test_serializer_duplicate_with_whitespace(self):
        """Test that serializer catches duplicates even with surrounding whitespace"""
        data = {
            "client_name": "  Test Client  ", 
            "client_code": "TC003"
        }
        serializer = ClientSerializer(data=data)
        self.assertFalse(serializer.is_valid())
        self.assertIn("client_name", serializer.errors)

    def test_serializer_case_insensitive_duplicate(self):
        """Test that serializer catches case-insensitive duplicates"""
        data = {
            "client_name": "test client", 
            "client_code": "TC004"
        }
        serializer = ClientSerializer(data=data)
        self.assertFalse(serializer.is_valid())
        self.assertIn("client_name", serializer.errors)

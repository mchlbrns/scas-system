import pytest
from rest_framework.test import APIClient
from rest_framework import status
from django.urls import reverse
from accounts.models import ImportSchema, ColumnMapping, Account
from clients.models import Client
from analysts.models import Analyst
from django.contrib.auth.models import User
from decimal import Decimal
from datetime import date

@pytest.mark.django_db
class TestAnalystViewConfiguration:
    def setup_method(self):
        self.client = APIClient()
        
        # 1. Setup Admin User
        self.admin_user = User.objects.create_superuser(username='admin', password='password')
        
        # 2. Setup Client
        self.client_obj = Client.objects.create(client_code='CL001', client_name='Test Client')
        
        # 3. Setup Analyst User
        self.analyst_user = User.objects.create_user(username='analyst', password='password')
        self.analyst = Analyst.objects.create(user=self.analyst_user)

    def test_admin_configures_view_and_analyst_sees_data(self):
        """
        Scenario:
        1. Admin creates an Import Schema with specific 'display_config'.
        2. Admin imports data (simulated by creating Account).
        3. Analyst fetches Schema and Accounts to view endorsements.
        """
        
        # --- Step 1: Admin configures view ---
        self.client.force_authenticate(user=self.admin_user)
        
        display_config = {
            "visible_columns": [
                "account_number", 
                "account_name", 
                "outstanding_balance", 
                "data.custom_field_1"  # Custom field from payload
            ]
        }
        
        schema_data = {
            "client": self.client_obj.id,
            "name": "Default Template",
            "is_active": True,
            "display_config": display_config,
            "column_mappings": [] # Simplified for this test, usually has mappings
        }
        
        response = self.client.post('/api/v1/accounts/import-schemas/', schema_data, format='json')
        assert response.status_code == status.HTTP_201_CREATED
        schema_id = response.data['id']
        
        # Verify DB
        schema = ImportSchema.objects.get(id=schema_id)
        assert schema.display_config == display_config

        # --- Step 2: Data exists (simulating import) ---
        account = Account.objects.create(
            client=self.client_obj,
            account_number="ACC-101",
            account_name="John Doe",
            endorsement_date=date.today(),
            outstanding_balance=Decimal("1500.00"),
            data_payload={"custom_field_1": "VIP Customer", "hidden_field": "Secret"}
        )

        # --- Step 3: Analyst views the data ---
        self.client.force_authenticate(user=self.analyst_user)
        
        # 3a. Analyst fetches the schema to know WHAT to show
        response_schema = self.client.get(f'/api/v1/accounts/import-schemas/?client={self.client_obj.id}')
        assert response_schema.status_code == status.HTTP_200_OK
        
        # Find active schema
        results = response_schema.data['results']
        active_schema = next((s for s in results if s['is_active']), None)
        assert active_schema is not None
        assert active_schema['display_config'] == display_config
        
        # 3b. Analyst fetches the account data
        response_accounts = self.client.get(f'/api/v1/accounts/accounts/?client={self.client_obj.id}')
        assert response_accounts.status_code == status.HTTP_200_OK
        
        account_data = response_accounts.data['results'][0]
        assert account_data['account_number'] == "ACC-101"
        # Ensure payload is available for the frontend to parse based on config
        assert account_data['data_payload']['custom_field_1'] == "VIP Customer"
        
        print("\nTest Verification Successful:")
        print(f"1. Schema Configured with columns: {display_config['visible_columns']}")
        print(f"2. Account Data returned with payload: {account_data['data_payload']}")

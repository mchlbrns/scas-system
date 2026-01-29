import pytest
import io
import csv
from decimal import Decimal
from rest_framework import status
from accounts.models import Account, ImportSchema, ColumnMapping

@pytest.mark.django_db
def test_dynamic_import_success(api_client, client_data, user):
    api_client.force_authenticate(user=user)
    
    # 1. Create Schema
    schema = ImportSchema.objects.create(client=client_data, name="Test Schema")
    ColumnMapping.objects.create(schema=schema, csv_header="Client Ref", target_field="account_number")
    ColumnMapping.objects.create(schema=schema, csv_header="Debtor Name", target_field="account_name")
    ColumnMapping.objects.create(schema=schema, csv_header="Date Endorsed", target_field="endorsement_date")
    ColumnMapping.objects.create(schema=schema, csv_header="Total Due", target_field="outstanding_balance")
    # Extra data
    ColumnMapping.objects.create(schema=schema, csv_header="Mobile No", target_field="data_payload")

    # 2. Create CSV matching schema
    header = b"Client Ref,Debtor Name,Date Endorsed,Total Due,Mobile No\n"
    row = b"REF-001,John Dynamic,2026-02-15,5000.50,09171234567"
    
    file_obj = io.BytesIO(header + row)
    file_obj.name = 'dynamic.csv'
    
    url = '/api/v1/accounts/accounts/upload_csv/'
    data = {
        'file': file_obj,
        'client': client_data.id,
        'schema': schema.id 
    }

    # 3. Upload
    response = api_client.post(url, data, format='multipart')
    
    assert response.status_code == status.HTTP_200_OK
    assert response.data['created'] == 1
    assert response.data['schema_used'] == "Test Schema"

    # 4. Verify Account
    acc = Account.objects.get(account_number="REF-001")
    assert acc.account_name == "John Dynamic"
    assert acc.outstanding_balance == Decimal("5000.50")
    assert str(acc.endorsement_date) == "2026-02-15"
    assert acc.data_payload.get("Mobile No") == "09171234567"

@pytest.mark.django_db
def test_fallback_logic(api_client, client_data, user):
    """Test that it still works without a schema (using hardcoded logic)"""
    api_client.force_authenticate(user=user)
    
    # Standard Summit Header
    header = b"Agency,Endo Type,EndoDate,RecallDate,Account Name,Account No.,OSB\n"
    row = b"SUMMIT,Regular,10-Jan-2026,31-Mar-2026,Old Logic,ACC-OLD,100.00"
    
    file_obj = io.BytesIO(header + row)
    file_obj.name = 'fallback.csv'
    
    url = '/api/v1/accounts/accounts/upload_csv/'
    data = {
        'file': file_obj,
        'client': client_data.id
        # No schema provided
    }

    response = api_client.post(url, data, format='multipart')
    
    if response.status_code != 200:
        print(f"Error Response: {response.data}")

    assert response.status_code == status.HTTP_200_OK
    assert response.data['created'] == 1
    assert response.data['schema_used'] == "Fallback"
    
    acc = Account.objects.get(account_number="ACC-OLD")
    assert acc.account_name == "Old Logic"

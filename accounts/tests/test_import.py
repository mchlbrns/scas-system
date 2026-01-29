import pytest
import io
from decimal import Decimal
from rest_framework.test import APIClient
from rest_framework import status
from accounts.models import Account, ImportSchema, ColumnMapping
from clients.models import Client
from analysts.models import Analyst
from django.contrib.auth.models import User

@pytest.fixture
def summit_schema(client_data):
    schema = ImportSchema.objects.create(client=client_data, name="Summit Default", is_active=True)
    # Map Summit Headers
    ColumnMapping.objects.create(schema=schema, csv_header="Account No.", target_field="account_number")
    ColumnMapping.objects.create(schema=schema, csv_header="Account Name", target_field="account_name")
    ColumnMapping.objects.create(schema=schema, csv_header="EndoDate", target_field="endorsement_date", data_type="DATE")
    ColumnMapping.objects.create(schema=schema, csv_header="OSB", target_field="outstanding_balance", data_type="DECIMAL")
    return schema

@pytest.mark.django_db
def test_upload_csv_no_schema(api_client, client_data, user):
    """Test that upload fails if no schema exists for the client."""
    api_client.force_authenticate(user=user)
    
    csv_content = "Header1,Header2\nVal1,Val2"
    file_obj = io.BytesIO(csv_content.encode('utf-8'))
    file_obj.name = 'test.csv'
    
    data = {'file': file_obj, 'client': client_data.id}
    response = api_client.post('/api/v1/accounts/accounts/upload_csv/', data, format='multipart')
    
    assert response.status_code == status.HTTP_400_BAD_REQUEST
    assert "No Import Template found" in str(response.data)

@pytest.mark.django_db
def test_upload_csv_success(api_client, client_data, user, summit_schema):
    api_client.force_authenticate(user=user)
    # CSV Content mimicking Summit format
    csv_content = """Agency,Endo Type,EndoDate,RecallDate,Account Name,Account No.,OSB
SUMMIT,Regular,10-Jan-2026,31-Mar-2026,John Doe,ACC-123," 42,042.97 "
SUMMIT,Regular,10-Jan-2026,31-Mar-2026,Jane Smith,ACC-456,10500.50"""
    
    file_obj = io.BytesIO(csv_content.encode('utf-8'))
    file_obj.name = 'endorsements.csv'

    url = '/api/v1/accounts/accounts/upload_csv/'
    
    data = {
        'file': file_obj,
        'client': client_data.id
    }

    response = api_client.post(url, data, format='multipart')

    assert response.status_code == status.HTTP_200_OK
    assert response.data['created'] == 2
    assert response.data['updated'] == 0
    
    # Verify Data
    acc1 = Account.objects.get(account_number="ACC-123")
    assert acc1.account_name == "John Doe"
    assert acc1.outstanding_balance == Decimal("42042.97")
    assert str(acc1.endorsement_date) == "2026-01-10"

@pytest.mark.django_db
def test_upload_csv_update(api_client, client_data, user, summit_schema):
    api_client.force_authenticate(user=user)
    # Create existing
    Account.objects.create(
        client=client_data,
        account_number="ACC-123",
        account_name="Old Name",
        endorsement_date="2025-01-01",
        outstanding_balance=100.00
    )

    csv_content = """Agency,Endo Type,EndoDate,RecallDate,Account Name,Account No.,OSB
SUMMIT,Regular,10-Jan-2026,31-Mar-2026,New Name,ACC-123,500.00"""
    
    file_obj = io.BytesIO(csv_content.encode('utf-8'))
    file_obj.name = 'update.csv'
    
    url = '/api/v1/accounts/accounts/upload_csv/'

    data = {
        'file': file_obj,
        'client': client_data.id
    }

    response = api_client.post(url, data, format='multipart')

    assert response.status_code == status.HTTP_200_OK
    assert response.data['created'] == 0
    assert response.data['updated'] == 1

    acc1 = Account.objects.get(account_number="ACC-123")
    assert acc1.account_name == "New Name"
    assert acc1.outstanding_balance == 500.00

@pytest.mark.django_db
def test_upload_csv_latin1_encoding(api_client, client_data, user, summit_schema):
    api_client.force_authenticate(user=user)
    # 0xA5 is Yen symbol in Latin-1/Windows-1252. In UTF-8 it is invalid start byte.
    # We construct a byte string directly.
    # Content: Agency,Endo Type,EndoDate,RecallDate,Account Name,Account No.,OSB
    # Row: SUMMIT,Regular,10-Jan-2026,31-Mar-2026,Yen¥Name,ACC-YEN,100.00
    
    header = b"Agency,Endo Type,EndoDate,RecallDate,Account Name,Account No.,OSB\n"
    # Note the \xa5 for Yen symbol
    row = b"SUMMIT,Regular,10-Jan-2026,31-Mar-2026,Yen\xa5Name,ACC-YEN,100.00"
    
    file_obj = io.BytesIO(header + row)
    file_obj.name = 'latin1.csv'
    
    url = '/api/v1/accounts/accounts/upload_csv/'
    data = {
        'file': file_obj,
        'client': client_data.id
    }

    response = api_client.post(url, data, format='multipart')

    assert response.status_code == status.HTTP_200_OK
    assert response.data['created'] == 1
    
    acc = Account.objects.get(account_number="ACC-YEN")
    # In Python, decoding \xa5 from latin-1 gives standard Yen symbol '¥'
    assert acc.account_name == "Yen¥Name"

@pytest.mark.django_db
def test_upload_csv_duplicates(api_client, client_data, user, summit_schema):
    """Test importing a CSV with duplicate account numbers."""
    api_client.force_authenticate(user=user)
    
    # Create 3 existing accounts
    Account.objects.create(client=client_data, account_number="A1", account_name="Orig1", endorsement_date="2026-01-01", outstanding_balance=0)
    Account.objects.create(client=client_data, account_number="A2", account_name="Orig2", endorsement_date="2026-01-01", outstanding_balance=0)
    Account.objects.create(client=client_data, account_number="A3", account_name="Orig3", endorsement_date="2026-01-01", outstanding_balance=0)

    # CSV has 4 rows: A1, A2, A3, and A1 again (duplicate)
    csv_content = """Agency,Endo Type,EndoDate,RecallDate,Account Name,Account No.,OSB
SUMMIT,Regular,10-Jan-2026,31-Mar-2026,Update1,A1,100.00
SUMMIT,Regular,10-Jan-2026,31-Mar-2026,Update2,A2,100.00
SUMMIT,Regular,10-Jan-2026,31-Mar-2026,Update3,A3,100.00
SUMMIT,Regular,10-Jan-2026,31-Mar-2026,Update1_Dup,A1,200.00""" # This matches A1 again

    file_obj = io.BytesIO(csv_content.encode('utf-8'))
    file_obj.name = 'duplicates.csv'

    data = {'file': file_obj, 'client': client_data.id}
    response = api_client.post('/api/v1/accounts/accounts/upload_csv/', data, format='multipart')

    assert response.status_code == status.HTTP_200_OK
    # Expect 4 updates (A1 updated twice)
    assert response.data['updated'] == 4
    assert response.data['created'] == 0
    
    acc1 = Account.objects.get(account_number="A1")
    assert acc1.outstanding_balance == 200.00

@pytest.mark.django_db
def test_upload_excel_success(api_client, client_data, user, summit_schema):
    """Test importing an Excel (.xlsx) file."""
    try:
        import openpyxl
    except ImportError:
        pytest.skip("openpyxl not installed")

    api_client.force_authenticate(user=user)
    
    # Create Excel file in memory
    wb = openpyxl.Workbook()
    ws = wb.active
    # Headers
    ws.append(["Agency", "Endo Type", "EndoDate", "RecallDate", "Account Name", "Account No.", "OSB"])
    # Row
    ws.append(["SUMMIT", "Regular", "10-Jan-2026", "31-Mar-2026", "Excel User", "XLSX-123", "999.99"])
    
    file_obj = io.BytesIO()
    wb.save(file_obj)
    file_obj.seek(0)
    file_obj.name = 'test.xlsx'

    data = {'file': file_obj, 'client': client_data.id}
    response = api_client.post('/api/v1/accounts/accounts/upload_csv/', data, format='multipart')

    assert response.status_code == status.HTTP_200_OK
    assert response.data['created'] == 1
    
    acc = Account.objects.get(account_number="XLSX-123")
    assert acc.account_name == "Excel User"
    assert acc.outstanding_balance == Decimal("999.99")

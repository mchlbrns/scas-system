import csv
import io
import openpyxl
import xlrd
from datetime import datetime
from decimal import Decimal
from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser, FormParser
from django.db import transaction
from .models import Account, ImportSchema, ColumnMapping
from .serializers import AccountSerializer, ImportSchemaSerializer
from clients.models import Client

class ImportSchemaViewSet(viewsets.ModelViewSet):
    queryset = ImportSchema.objects.all()
    serializer_class = ImportSchemaSerializer
    filterset_fields = ['client']

class AccountViewSet(viewsets.ModelViewSet):
    queryset = Account.objects.all()
    serializer_class = AccountSerializer
    filterset_fields = ['client', 'status', 'assigned_analyst']
    search_fields = ['account_number', 'account_name']

    def get_queryset(self):
        return super().get_queryset().select_related('client', 'assigned_analyst')

    @action(detail=False, methods=['POST'], parser_classes=[MultiPartParser, FormParser])
    def upload_csv(self, request):
        file_obj = request.FILES.get('file')
        client_id = request.data.get('client')
        schema_id = request.data.get('schema') # Optional, if they select specific template

        if not file_obj or not client_id:
            return Response({"error": "File and Client ID required."}, status=status.HTTP_400_BAD_REQUEST)

        try:
            client = Client.objects.get(id=client_id)
            
            # Determine Schema
            # 1. Use schema_id if provided
            # 2. Else attempt to find a default/active schema for this client
            schema = None
            if schema_id:
                schema = ImportSchema.objects.filter(id=schema_id).first()
            else:
                schema = ImportSchema.objects.filter(client=client, is_active=True).first()

            if not schema:
                return Response(
                    {"error": f"No Import Template found for client '{client.client_name}'. Please create one in Administration > Import Templates."}, 
                    status=status.HTTP_400_BAD_REQUEST
                )

            # Dynamic Mapping Logic
            mappings = {}
            # { "CSV Header": "target_field" }
            for m in schema.column_mappings.all():
                mappings[m.csv_header.strip()] = m
            
            # Detect File Type and Parse
            filename = file_obj.name.lower()
            rows_data = [] # List of dicts

            try:
                if filename.endswith('.xlsx'):
                    wb = openpyxl.load_workbook(file_obj, data_only=True)
                    sheet = wb.active
                    headers = [str(cell.value).strip() if cell.value else f"Column{i}" for i, cell in enumerate(sheet[1])]
                    for row in sheet.iter_rows(min_row=2, values_only=True):
                        row_dict = {}
                        for i, val in enumerate(row):
                            if i < len(headers):
                                row_dict[headers[i]] = str(val).strip() if val is not None else ""
                        if any(row_dict.values()): # Skip empty rows
                            rows_data.append(row_dict)

                elif filename.endswith('.xls'):
                    file_content = file_obj.read()
                    wb = xlrd.open_workbook(file_contents=file_content)
                    sheet = wb.sheet_by_index(0)
                    headers = [str(cell.value).strip() if cell.value else f"Column{i}" for i, cell in enumerate(sheet.row(0))]
                    for row_idx in range(1, sheet.nrows):
                        row_dict = {}
                        for col_idx, cell in enumerate(sheet.row(row_idx)):
                            val = cell.value
                            if col_idx < len(headers):
                                # Handle dates in xlrd if needed, or just stringify
                                row_dict[headers[col_idx]] = str(val).strip() if val is not None else ""
                        if any(row_dict.values()):
                            rows_data.append(row_dict)

                else:
                    # Default to CSV
                    file_content = file_obj.read()
                    try:
                        decoded_file = file_content.decode('utf-8')
                    except UnicodeDecodeError:
                        decoded_file = file_content.decode('latin-1')
                    
                    io_string = io.StringIO(decoded_file)
                    reader = csv.DictReader(io_string)
                    rows_data = list(reader)

            except Exception as e:
                return Response({"error": f"File Parsing Error: {str(e)}"}, status=status.HTTP_400_BAD_REQUEST)
            
            created_count = 0
            updated_count = 0
            errors = []

            with transaction.atomic():
                for index, file_data in enumerate(rows_data):
                    try:
                        # Clean whitespace from keys/values
                        clean_data = {k.strip(): v.strip() for k, v in file_data.items() if k}
                        
                        acc_no = None
                        account_name = "Unknown"
                        endo_date = datetime.today().date() # Default
                        recall_date = None
                        osb = Decimal(0)
                        data_payload = {}
                        
                        # --- STRICT DYNAMIC LOGIC ---
                        # Iterate over row keys (headers)
                        # If header exists in mappings -> map to target field
                        # If not -> add to data_payload
                        
                        for csv_key, csv_val in clean_data.items():
                            mapping = mappings.get(csv_key)
                            if mapping:
                                target = mapping.target_field
                                
                                if target == 'account_number':
                                    acc_no = csv_val
                                elif target == 'account_name':
                                    account_name = csv_val
                                elif target == 'endorsement_date':
                                    parsed_date = self._parse_date(csv_val)
                                    if parsed_date: endo_date = parsed_date
                                elif target == 'recall_date':
                                    recall_date = self._parse_date(csv_val)
                                elif target == 'outstanding_balance':
                                    osb = self._parse_decimal(csv_val)
                                elif target == 'data_payload':
                                    data_payload[csv_key] = csv_val
                            else:
                                # Unmapped field -> payload
                                data_payload[csv_key] = csv_val
                        
                        if not acc_no:
                            # Skip rows without ID
                            continue

                        obj, created = Account.objects.update_or_create(
                            client=client,
                            account_number=acc_no,
                            defaults={
                                'account_name': account_name,
                                'endorsement_date': endo_date,
                                'recall_date': recall_date,
                                'outstanding_balance': osb,
                                'data_payload': data_payload
                            }
                        )
                        if created: created_count += 1
                        else: updated_count += 1
                        
                    except Exception as e:
                        errors.append(f"Row {index+1}: {str(e)}")

            return Response({
                "message": "Import Processed",
                "schema_used": schema.name if schema else "Fallback",
                "created": created_count,
                "updated": updated_count,
                "errors": errors[:10]
            }, status=status.HTTP_200_OK)

        except Exception as e:
            return Response({"error": f"Process Error: {str(e)}"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def _parse_decimal(self, val_str):
        try:
            clean = val_str.replace(',', '').replace('"', '').replace(' ', '')
            return Decimal(clean)
        except:
            return Decimal(0)

    def _parse_date(self, date_str):
        formats = ['%d-%b-%Y', '%Y-%m-%d', '%m/%d/%Y', '%d/%m/%Y']
        for fmt in formats:
            try:
                return datetime.strptime(date_str, fmt).date()
            except ValueError:
                continue
        return None

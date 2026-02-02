import csv
import io
import openpyxl
import xlrd
from datetime import datetime, date
from decimal import Decimal
from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser, FormParser
from django.db import transaction
from .models import Account, ImportSchema, ColumnMapping, ImportBatch, ActivityLog, AccountPTP
from .serializers import (
    AccountSerializer, ImportSchemaSerializer, ImportBatchSerializer,
    ActivityLogSerializer, AccountPTPSerializer
)

class ImportSchemaViewSet(viewsets.ModelViewSet):
    queryset = ImportSchema.objects.all()
    serializer_class = ImportSchemaSerializer
    filterset_fields = ['client']

class ImportBatchViewSet(viewsets.ModelViewSet):
    queryset = ImportBatch.objects.all()
    serializer_class = ImportBatchSerializer
    filterset_fields = ['client']

class AccountViewSet(viewsets.ModelViewSet):
    queryset = Account.objects.all()
    serializer_class = AccountSerializer
    filterset_fields = ['client', 'status', 'assigned_analyst', 'import_batch']
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

            # Dynamic Mapping Logic - Case Insensitive
            mappings = {}
            # { "csv header (lower)": mapping_obj }
            for m in schema.column_mappings.all():
                mappings[m.csv_header.strip().lower()] = m
            
            # Detect File Type and Parse
            filename = file_obj.name.lower()
            original_filename = file_obj.name
            rows_data = [] # List of dicts

            try:
                if filename.endswith('.xlsx'):
                    wb = openpyxl.load_workbook(file_obj, data_only=True)
                    sheet = wb.active
                    # normalize headers to string, strip, and lower
                    raw_headers = [str(cell.value).strip() for cell in sheet[1]]
                    headers = self._deduplicate_headers(raw_headers)
                    for row in sheet.iter_rows(min_row=2, values_only=True):
                        row_dict = {}
                        for i, val in enumerate(row):
                            if i < len(headers):
                                # If val is None, use empty string
                                row_dict[headers[i]] = val if val is not None else ""
                        # Check if row has any non-empty values
                        if any(str(v).strip() for v in row_dict.values() if v is not None):
                            rows_data.append(row_dict)

                elif filename.endswith('.xls'):
                    file_content = file_obj.read()
                    wb = xlrd.open_workbook(file_contents=file_content)
                    sheet = wb.sheet_by_index(0)
                    raw_headers = [str(cell.value).strip() for cell in sheet.row(0)]
                    headers = self._deduplicate_headers(raw_headers)
                    for row_idx in range(1, sheet.nrows):
                        row_dict = {}
                        for col_idx, cell in enumerate(sheet.row(row_idx)):
                            val = cell.value
                            if col_idx < len(headers):
                                row_dict[headers[col_idx]] = val if val is not None else ""
                        if any(str(v).strip() for v in row_dict.values() if v is not None):
                            rows_data.append(row_dict)

                else:
                    # Default to CSV
                    file_content = file_obj.read()
                    try:
                        decoded_file = file_content.decode('utf-8-sig') # Handle BOM
                    except UnicodeDecodeError:
                        decoded_file = file_content.decode('latin-1')
                    
                    io_string = io.StringIO(decoded_file)
                    # Manually handle headers to deduplicate
                    csv_reader = csv.reader(io_string)
                    try:
                        raw_headers = next(csv_reader)
                        headers = self._deduplicate_headers([h.strip() for h in raw_headers])
                        reader = csv.DictReader(io_string, fieldnames=headers)
                        rows_data = list(reader)
                    except StopIteration:
                        rows_data = []

            except Exception as e:
                return Response({"error": f"File Parsing Error: {str(e)}"}, status=status.HTTP_400_BAD_REQUEST)
            
            created_count = 0
            updated_count = 0
            errors = []
            
            # Create Batch
            batch = ImportBatch.objects.create(
                client=client,
                filename=original_filename,
                record_count=0 
            )
            
            # Track endorsement dates to find the most common one for the batch
            endorsement_dates = []

            with transaction.atomic():
                for index, file_data in enumerate(rows_data):
                    try:
                        # Normalize data keys to lower for matching
                        # file_data values are raw (could be int, datetime, etc from excel)
                        clean_data = {}
                        for k, v in file_data.items():
                            if k:
                                clean_data[str(k).strip().lower()] = v
                        
                        acc_no = None
                        account_name = "Unknown"
                        endo_date = datetime.today().date()
                        recall_date = None
                        osb = Decimal(0)
                        data_payload = {}
                        
                        # Iteration strategy: Loop through MAPPINGS to find them in the ROW
                        # This handles the case where the row has extra columns we don't care about,
                        # and ensures we look for every mapped field.
                        
                        # BUT we also want to capture unmapped fields into data_payload.
                        # So let's loop through the ROW (clean_data).
                        
                        for csv_key, raw_val in clean_data.items():
                            mapping = mappings.get(csv_key)
                            
                            # Convert raw_val to string for storage/payload unless it's being parsed
                            val_str = str(raw_val).strip() if raw_val is not None else ""

                            if mapping:
                                target = mapping.target_field
                                
                                if target == 'account_number':
                                    acc_no = val_str
                                elif target == 'account_name':
                                    account_name = val_str
                                elif target == 'endorsement_date':
                                    parsed_date = self._parse_date(raw_val)
                                    if parsed_date: endo_date = parsed_date
                                elif target == 'recall_date':
                                    parsed_date = self._parse_date(raw_val)
                                    if parsed_date: recall_date = parsed_date
                                elif target == 'outstanding_balance':
                                    osb = self._parse_decimal(val_str)
                                elif target == 'data_payload':
                                    data_payload[mapping.csv_header] = val_str # Use original case for payload key if preferred, or csv_key
                            else:
                                # Unmapped field -> payload
                                # Use the key as is (lowercase) or try to recover original? 
                                # Lowercase is safer for consistency.
                                data_payload[csv_key] = val_str
                        
                        if not acc_no:
                            # Skip rows without ID
                            continue
                        
                        endorsement_dates.append(endo_date)

                        obj, created = Account.objects.update_or_create(
                            client=client,
                            account_number=acc_no,
                            defaults={
                                'account_name': account_name,
                                'endorsement_date': endo_date,
                                'recall_date': recall_date,
                                'outstanding_balance': osb,
                                'data_payload': data_payload,
                                'import_batch': batch 
                            }
                        )
                        if created: created_count += 1
                        else: updated_count += 1
                        
                    except Exception as e:
                        errors.append(f"Row {index+1}: {str(e)}")
            
            # Update Batch Meta
            batch.record_count = created_count + updated_count
            if endorsement_dates:
                # Find most common date
                from collections import Counter
                most_common_date = Counter(endorsement_dates).most_common(1)[0][0]
                batch.endorsement_date = most_common_date
            batch.save()

            return Response({
                "message": "Import Processed",
                "schema_used": schema.name if schema else "Fallback",
                "created": created_count,
                "updated": updated_count,
                "batch_id": batch.id,
                "errors": errors[:10]
            }, status=status.HTTP_200_OK)

        except Exception as e:
            return Response({"error": f"Process Error: {str(e)}"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def _deduplicate_headers(self, headers):
        counts = {}
        new_headers = []
        for h in headers:
            # Case insensitive counting could be safer, but headers list is already raw strings.
            # We want to preserve case in output but maybe count sensitively? 
            # The current logic uses 'h' as key. If headers are ['Address', 'address'], they are distinct.
            # If the user issue is exact duplicates 'Address', 'Address', this works.
            if h in counts:
                counts[h] += 1
                new_headers.append(f"{h}_{counts[h]}")
            else:
                counts[h] = 0
                new_headers.append(h)
        return new_headers

    def _parse_decimal(self, val_str):
        try:
            if not val_str: return Decimal(0)
            clean = val_str.replace(',', '').replace('"', '').replace(' ', '').replace('$', '')
            return Decimal(clean)
        except:
            return Decimal(0)

    def _parse_date(self, val):
        if val is None:
            return None
            
        # If it's already a datetime/date object (from openpyxl)
        if isinstance(val, (datetime, date)):
            return val if isinstance(val, date) and not isinstance(val, datetime) else val.date()
        
        # If it's a string, try parsing
        date_str = str(val).strip()
        if not date_str:
            return None

        formats = [
            '%d-%b-%Y', '%Y-%m-%d', '%m/%d/%Y', '%d/%m/%Y',
            '%Y-%m-%d %H:%M:%S', '%d-%b-%y', '%m-%d-%Y'
        ]
        for fmt in formats:
            try:
                return datetime.strptime(date_str, fmt).date()
            except ValueError:
                continue
        return None

class ActivityLogViewSet(viewsets.ModelViewSet):
    queryset = ActivityLog.objects.all()
    serializer_class = ActivityLogSerializer
    filterset_fields = ['account', 'action', 'outcome', 'created_by']

class AccountPTPViewSet(viewsets.ModelViewSet):
    queryset = AccountPTP.objects.all()
    serializer_class = AccountPTPSerializer
    filterset_fields = ['account', 'status', 'created_by']


---
name: file_ingestion_specialist
description: specialized in implementing robust file upload handlers in Django/DRF, supporting Excel (.xlsx, .xls) and CSV with safe type coercion, header deduplication, and atomic batch processing.
---

# File Ingestion Specialist

## Description
This skill provides a standardized approach to handling file uploads in Django. It prevents common errors like "isinstance type" bugs (dates), BOM encoding issues (CSV), and partial data commits. It promotes the "Batch -> Record" data model and handles duplicate headers (e.g., 'Address', 'Address' -> 'Address', 'Address_1').

## Inputs
- **Request**: `request.FILES['file']`
- **Context**: Client ID, Schema (optional)
- **Target Model**: The model to create records in (e.g., `Account`).

## Process

### 1. Robust File Parsing
Do not rely on a single library. Switch based on extension.
- **.xlsx**: Use `openpyxl`. MUST use `data_only=True` to get values, not formulas.
- **.xls**: Use `xlrd`.
- **.csv**: Use `csv.DictReader` ONLY after manually deduplicating headers.

### 2. Header Normalization & Deduplication
Never trust raw headers. They may be duplicates.

**Helper**:
```python
def _deduplicate_headers(self, headers):
    counts = {}
    new_headers = []
    for h in headers:
        if h in counts:
            counts[h] += 1
            new_headers.append(f"{h}_{counts[h]}")
        else:
            counts[h] = 0
            new_headers.append(h)
    return new_headers
```

**Usage (CSV)**:
```python
io_string = io.StringIO(decoded_file)
csv_reader = csv.reader(io_string)
try:
    raw_headers = next(csv_reader)
    # Strip then deduplicate
    clean_headers = self._deduplicate_headers([h.strip() for h in raw_headers])
    # Pass clean_headers to fieldnames
    reader = csv.DictReader(io_string, fieldnames=clean_headers)
    rows = list(reader)
except StopIteration:
    return []
```

### 3. Safe Type Coercion Helpers
Implement these private helpers in your ViewSet or Utility class.

**Date Parsing**:
```python
def _parse_date(self, val):
    if val is None: return None
    # Handle Python objects (from Excel libs)
    if isinstance(val, (datetime, date)):
        return val if isinstance(val, date) and not isinstance(val, datetime) else val.date()
    
    # Handle Strings
    val_str = str(val).strip()
    if not val_str: return None
    
    formats = ['%Y-%m-%d', '%d-%b-%Y', '%m/%d/%Y', '%d/%m/%Y']
    for fmt in formats:
        try: return datetime.strptime(val_str, fmt).date()
        except ValueError: continue
    return None
```

**Decimal Parsing**:
```python
def _parse_decimal(self, val):
    if not val: return Decimal(0)
    clean = str(val).replace(',', '').replace('$', '').strip()
    return Decimal(clean)
```

### 4. Atomic Batch Processing
Always wrap the row iteration in a transaction to prevent partial imports.
```python
batch = ImportBatch.objects.create(...)
with transaction.atomic():
    for row in rows:
        # data processing...
        Model.objects.create(..., import_batch=batch)
```

## Verification Checklist
1.  [ ] Did you import `date` from `datetime`? (`from datetime import datetime, date`)
2.  [ ] Are you deduping headers before creating `DictReader`?
3.  [ ] Is `transaction.atomic()` used?
4.  [ ] Are headers stripped and lowercased for mapping keys?

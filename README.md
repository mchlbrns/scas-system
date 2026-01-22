# Daily Collection Monitoring System (DCMS)

A Django-based backend for tracking daily collections, targets, and aggregations.

## Tech Stack
- Python 3.11+
- Django 4.x
- Django REST Framework
- MariaDB (Configured in `settings.py`)

## Setup

1. **Install Dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

2. **Database Setup**:
   - Ensure MariaDB is running.
   - Create a database named `dcms_db` (or update `settings.py`).
   - Run migrations:
     ```bash
     python manage.py makemigrations
     python manage.py migrate
     ```

3. **Run Server**:
   ```bash
   python manage.py runserver
   ```

## API Documentation

### Authentication
- Use JWT Authentication.
- Obtain Token: (Standard SimpleJWT endpoints should be added to `urls.py` if needed, but not explicitly requested. Currently standard `IsAuthenticated` is enforced.)
- *Note: To add Login endpoint, add `path('api/token/', TokenObtainPairView.as_view())` to `urls.py`.* (I'll add this now to be complete)

### Endpoints

#### Core
- `GET /api/v1/clients/`
- `GET /api/v1/analysts/`
- `GET /api/v1/targets/`

#### Transactions
- `GET /api/v1/receivables/`
- `GET /api/v1/payments/`
- `GET /api/v1/ptp/`

#### Dashboard
- `GET /api/v1/dashboard/client_summary/?date=YYYY-MM-DD&client=<id>`
- `GET /api/v1/dashboard/team_summary/?date=YYYY-MM-DD`
- `GET /api/v1/dashboard/grand_total/?date=YYYY-MM-DD`

## Models
- **Client**: `client_name`, `is_active`
- **Analyst**: `analyst_name`, `is_active`
- **Receivable**: Daily snapshot of POS/NEG accounts and amounts per Client/Analyst.
- **DailyPayment**: Payment amount per Client/Analyst/Date.
- **DailyPTP**: PTP amount per Client/Analyst/Date.
- **Target**: Monthly targets per Client.

## Logic
- **% Achievement**: `(MTD Payment / Client Target) * 100`
- **Variance**: `Client Target - MTD Payment`

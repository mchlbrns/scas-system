# SCASI (Daily Collection Monitoring System)

## Project Overview
SCASI (System for Collection Analysis and Strategy Implementation), also referred to as DCMS, is a full-stack application designed for monitoring and analyzing daily collections. It features a decoupled architecture with a Django REST Framework backend and a Next.js frontend.

## Technology Stack

### Backend (Root Directory)
*   **Framework:** Django 4.2+
*   **API:** Django REST Framework (DRF)
*   **Database:** MySQL (`mysqlclient`)
*   **Authentication:** JWT (`rest_framework_simplejwt`)
*   **Key Libraries:**
    *   `django-filter`: Query filtering
    *   `django-cors-headers`: Cross-origin resource sharing
    *   `python-decouple`: Configuration management
*   **Testing:** `pytest`, `factory-boy`

### Frontend (`/frontend`)
*   **Framework:** Next.js 16 (React 19)
*   **Language:** TypeScript
*   **Styling:** Tailwind CSS 4
*   **State Management:** Zustand
*   **Data Fetching:** TanStack Query (React Query)
*   **Forms:** React Hook Form + Zod
*   **Visualization:** Recharts
*   **Testing:** Vitest, React Testing Library

## Project Structure

### Backend Apps
*   **`core`**: Shared utilities, middleware (Audit Log), and permissions.
*   **`analysts`**: User management for collection analysts.
*   **`clients`**: Client data management.
*   **`receivables`**: Core financial data (accounts receivable).
*   **`payments`**: Payment tracking and processing.
*   **`ptp`**: "Promise to Pay" tracking.
*   **`targets`**: Collection targets and goals.
*   **`teams`**: Team structure and hierarchy.
*   **`dashboard`**: Aggregated views and metrics.

### Agent System (`/.agent`)
This repository is managed by an autonomous agent ("Nexus").
*   **Skills:** Defined capabilities (e.g., `django_test_specialist`, `react_data_patterns`) located in `.agent/skills`.
*   **Workflows:** Standardized procedures (e.g., `initiate`, `self_fix`) located in `.agent/workflows`.
*   **Memory:** Project context and logs located in `.agent/memory`.

## Setup and Development

### Prerequisites
*   Python 3.10+
*   Node.js 18+
*   MySQL Database

### Environment Configuration
1.  **Backend:** Create a `.env` file in the root directory (see `.env.example`).
    *   Required: `SECRET_KEY`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_HOST`.
2.  **Frontend:** Create a `.env.local` file in `frontend/`.
    *   Required: `NEXT_PUBLIC_API_URL` (default: `http://localhost:8000/api`).

### Running the Application
The project includes convenience scripts in the `scripts/` directory.

**Windows (Primary):**
*   Run `scripts/run_dcms.bat`.
    *   This script automatically:
        1.  Activates the Python virtual environment.
        2.  Runs Django migrations (`makemigrations` & `migrate`).
        3.  Starts the Django development server on port 8000.
        4.  Starts the Next.js development server on port 3000.

**Manual Start:**
1.  **Backend:**
    ```bash
    # Activate venv
    python manage.py migrate
    python manage.py runserver
    ```
2.  **Frontend:**
    ```bash
    cd frontend
    npm run dev
    ```

### Testing
*   **Backend:** Run `pytest` from the root directory.
*   **Frontend:** Run `npm run test` (Vitest) from the `frontend/` directory.

## Development Conventions
*   **Code Style:** Follow PEP 8 for Python and standard Prettier/ESLint configurations for TypeScript.
*   **API Pattern:** DRF ViewSets with standard filtering and pagination.
*   **Frontend Pattern:** 
    *   Hooks for data fetching (React Query).
    *   Zustand for global client-side state (Auth).
    *   Strict TypeScript typing for all components and API responses.

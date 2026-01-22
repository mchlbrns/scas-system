@echo off
cd /d "%~dp0"
echo Starting DCMS System...

:: Start Backend
echo Launching Backend...
:: Activate venv, run migrations (make & apply), then start server
start "DCMS Backend" cmd /k "if exist venv\Scripts\activate.bat (call venv\Scripts\activate.bat) && echo Checking for model changes... && python manage.py makemigrations && echo Applying migrations... && python manage.py migrate && echo Starting Django Server... && python manage.py runserver"

:: Start Frontend
echo Launching Frontend...
start "DCMS Frontend" cmd /k "cd frontend && echo Starting Next.js... && npm run dev"

echo.
echo ===================================================
echo DCMS is starting securely.
echo Backend:  http://localhost:8000
echo Frontend: http://localhost:3000
echo ===================================================
echo.
pause

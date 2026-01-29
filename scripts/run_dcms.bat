@echo off
:: Navigate to project root (parent of scripts folder)
cd /d "%~dp0\.."

echo ===================================================
echo SCASI / DCMS System Launcher
echo ===================================================
echo.
echo Select Run Mode:
echo 1. Development (Hot-reload, Debug On) - Default
echo 2. Production (Optimized, Secure, Waitress + Next.js Build)
echo.

set mode=1
set /p mode="Enter choice [1]: "

if "%mode%"=="2" goto prod

:dev
echo.
echo ---------------------------------------------------
echo Starting DCMS System in DEVELOPMENT mode...
echo ---------------------------------------------------

:: Start Backend
echo Launching Backend...
start "DCMS Backend (Dev)" cmd /k "if exist venv\Scripts\activate.bat (call venv\Scripts\activate.bat) && echo Checking for model changes... && python manage.py makemigrations && echo Applying migrations... && python manage.py migrate && echo Starting Django Server... && python manage.py runserver 0.0.0.0:8000"

:: Start Frontend
echo Launching Frontend...
start "DCMS Frontend (Dev)" cmd /k "cd frontend && echo Starting Next.js... && npm run dev"

goto info

:prod
echo.
echo ---------------------------------------------------
echo Starting DCMS System in PRODUCTION mode...
echo This may take a few minutes to build...
echo ---------------------------------------------------

:: Start Backend
echo Launching Backend (Waitress)...
:: note: pip install is included to ensure waitress is present
start "DCMS Backend (Prod)" cmd /k "if exist venv\Scripts\activate.bat (call venv\Scripts\activate.bat) && echo Checking dependencies... && pip install -r requirements.txt && echo Applying migrations... && python manage.py migrate && echo Starting Waitress Server... && waitress-serve --listen=*:8000 dcms.wsgi:application"

:: Start Frontend
echo Launching Frontend (Next.js Production)...
start "DCMS Frontend (Prod)" cmd /k "cd frontend && echo Installing dependencies... && npm install && echo Building application... && npm run build && echo Starting Next.js Server... && npm start"

goto info

:info
echo.
echo ===================================================
echo DCMS is currently running.
echo.
echo Backend API: http://localhost:8000
echo User Interface: http://localhost:3000
echo.
echo Keep these windows open to keep the server running.
echo ===================================================
echo.
pause

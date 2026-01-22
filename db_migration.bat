@echo off
cd /d "%~dp0"
echo Updating Database Schema...

:: Check if venv exists and activate
if exist "venv\Scripts\activate.bat" (
    echo Activating virtual environment...
    call venv\Scripts\activate.bat
)

:: Run Make Migrations
echo Creating new migrations...
python manage.py makemigrations

:: Run Migrate
echo Applying migrations...
python manage.py migrate

echo Database update complete.
pause

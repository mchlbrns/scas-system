# scripts/restore.ps1
# Automates the SCASI recovery protocol

param (
    [Parameter(Mandatory=$false)]
    [switch]$Git,
    
    [Parameter(Mandatory=$false)]
    [switch]$DB,
    
    [Parameter(Mandatory=$false)]
    [string]$BackupFile
)

$ErrorActionPreference = "Stop"

function Write-Info($text) { Write-Host "[INFO] $text" -ForegroundColor Cyan }
function Write-Success($text) { Write-Host "[SUCCESS] $text" -ForegroundColor Green }
function Write-ErrorText($text) { Write-Host "[ERROR] $text" -ForegroundColor Red }

# Default to Git + DB if no flags provided
if (-not $Git -and -not $DB) {
    $Git = $true
    $DB = $true
}

try {
    Write-Info "Starting SCASI Restoration Protocol..."

    # 1. Git Restore
    if ($Git) {
        Write-Info "Restoring code state to HEAD..."
        git restore .
        git clean -fd
        Write-Success "Codebase restored."
    }

    # 2. DB Restore
    if ($DB) {
        Write-Info "Triggering Database Restoration..."
        $scriptPath = Join-Path $PSScriptRoot "restore_db.ps1"
        if (Test-Path $scriptPath) {
            if ($BackupFile) {
                & $scriptPath -BackupFile "$BackupFile"
            } else {
                & $scriptPath
            }
            Write-Success "Database restored."
        } else {
            Write-ErrorText "restore_db.ps1 not found in $PSScriptRoot"
        }
    }

    Write-Success "Restoration protocol complete!"
} catch {
    Write-ErrorText "Restoration failed: $_"
    exit 1
}

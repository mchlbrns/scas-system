# scripts/sync.ps1
# Automates the SCASI deployment loop

param (
    [Parameter(Mandatory=$false)]
    [string]$Message,
    
    [Parameter(Mandatory=$false)]
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

function Write-Info($text) { Write-Host "[INFO] $text" -ForegroundColor Cyan }
function Write-Success($text) { Write-Host "[SUCCESS] $text" -ForegroundColor Green }
function Write-ErrorText($text) { Write-Host "[ERROR] $text" -ForegroundColor Red }

try {
    Write-Info "Starting SCASI Synchronization Protocol..."
    
    # 1. Check for changes
    $status = git status --porcelain
    if (-not $status) {
        Write-Info "No changes detected. Workspace is clean."
        exit 0
    }

    # 2. Add changes
    Write-Info "Staging changes..."
    if (-not $DryRun) { git add . }

    # 3. Commit
    if (-not $Message) {
        $Message = Read-Host "Enter commit message"
    }
    
    if (-not $Message) {
        Write-ErrorText "Commit message cannot be empty."
        exit 1
    }

    Write-Info "Committing changes: $Message"
    if (-not $DryRun) { git commit -m "$Message" }

    # 4. Push
    $branch = git branch --show-current
    Write-Info "Pushing to origin/$branch..."
    if (-not $DryRun) {
        git push origin "$branch"
    } else {
        Write-Info "[DRY RUN] Would execute: git push origin $branch"
    }

    Write-Success "Synchronization complete!"
} catch {
    Write-ErrorText "Sync failed: $_"
    exit 1
}

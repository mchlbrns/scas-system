# backup_db.ps1
# MariaDB Backup Script for SCASI

$EnvFile = Join-Path $PSScriptRoot "..\.env"
$BackupDir = Join-Path $PSScriptRoot "..\backups"

if (-not (Test-Path $EnvFile)) {
    Write-Error ".env file not found at $EnvFile"
    exit 1
}

# Create backups directory if missing
if (-not (Test-Path $BackupDir)) {
    New-Item -ItemType Directory -Path $BackupDir | Out-Null
    Write-Host "Created backups directory: $BackupDir" -ForegroundColor Cyan
}

# Function to extract values from .env
function Get-EnvVar($Key) {
    $Line = Get-Content $EnvFile | Select-String -Pattern "^$Key="
    if ($Line) {
        return $Line.ToString().Split('=')[1].Trim()
    }
    return $null
}

# Function to find MariaDB binaries
function Find-Binary($BinaryName) {
    # 1. Check if defined in .env
    $BinPath = Get-EnvVar "DB_BIN_PATH"
    if ($BinPath) {
        $FullPath = Join-Path $BinPath "$BinaryName.exe"
        if (Test-Path $FullPath) { return $FullPath }
    }

    # 2. Check if in system PATH
    $WhereResult = Get-Command $BinaryName -ErrorAction SilentlyContinue
    if ($WhereResult) { return $WhereResult.Source }

    # 3. Check common Windows paths
    $CommonPathRoots = @(
        "C:\Program Files\MariaDB*",
        "C:\Program Files\MySQL*",
        "C:\xampp\mysql",
        "C:\laragon\bin\mysql\*"
    )
    
    foreach ($RootPattern in $CommonPathRoots) {
        $Roots = Get-ChildItem -Path (Split-Path $RootPattern -Parent) -Filter (Split-Path $RootPattern -Leaf) -ErrorAction SilentlyContinue
        foreach ($Root in $Roots) {
            $BinPath = Join-Path $Root.FullName "bin"
            $FullPath = Join-Path $BinPath "$BinaryName.exe"
            if (Test-Path $FullPath) { return $FullPath }

            # Some might have the binary in the root (like Laragon)
            $FullPath = Join-Path $Root.FullName "$BinaryName.exe"
            if (Test-Path $FullPath) { return $FullPath }
        }
    }

    return $null
}

# Load credentials
$DbName = Get-EnvVar "DB_NAME"
$DbUser = Get-EnvVar "DB_USER"
$DbPass = Get-EnvVar "DB_PASSWORD"
$DbHost = Get-EnvVar "DB_HOST"
$DbPort = Get-EnvVar "DB_PORT"

if (-not $DbName -or -not $DbUser) {
    Write-Error "Required DB credentials (DB_NAME, DB_USER) missing from .env"
    exit 1
}

# Find mysqldump
$DumpBin = Find-Binary "mysqldump"
if (-not $DumpBin) {
    Write-Error "mysqldump.exe not found. Please add the MariaDB bin folder to your PATH or set DB_BIN_PATH in .env"
    exit 1
}

$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$OutputFile = Join-Path $BackupDir "backup_${DbName}_${Timestamp}.sql"

Write-Host "Starting backup of $DbName using $DumpBin..." -ForegroundColor Yellow

# Construct mysqldump command
$DumpCommand = "`"$DumpBin`" --host=$DbHost --port=$DbPort --user=$DbUser --password=$DbPass $DbName"

# Execute
try {
    # Using the call operator & and Out-File for native PowerShell redirection
    # We remove -NoNewline to ensure SQL line endings are preserved
    $p = "--host=$DbHost", "--port=$DbPort", "--user=$DbUser", "--password=$DbPass", "$DbName"
    & "$DumpBin" $p | Out-File -FilePath "$OutputFile" -Encoding UTF8
    
    if ($LASTEXITCODE -eq 0) {
        $FileSize = (Get-Item $OutputFile).Length / 1KB
        Write-Host "Backup successful! Saved to: $OutputFile ($($FileSize.ToString('F2')) KB)" -ForegroundColor Green
    } else {
        Write-Error "mysqldump failed with exit code $LASTEXITCODE"
    }
} catch {
    Write-Error "An error occurred during backup: $_"
}

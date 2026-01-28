# restore_db.ps1
# MariaDB Restore Script for SCASI

param (
    [string]$BackupFile
)

$EnvFile = Join-Path $PSScriptRoot "..\.env"
$BackupDir = Join-Path $PSScriptRoot "..\backups"

if (-not (Test-Path $EnvFile)) {
    Write-Error ".env file not found at $EnvFile"
    exit 1
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
    Write-Error "Required DB credentials missing from .env"
    exit 1
}

# Find mysql binary
$MysqlBin = Find-Binary "mysql"
if (-not $MysqlBin) {
    Write-Error "mysql.exe not found. Please add the MariaDB bin folder to your PATH or set DB_BIN_PATH in .env"
    exit 1
}

# If no backup file provided, list available backups and prompt
if (-not $BackupFile) {
    if (-not (Test-Path $BackupDir)) {
        Write-Error "Backups directory not found at $BackupDir"
        exit 1
    }
    
    $Files = Get-ChildItem -Path $BackupDir -Filter "*.sql" | Sort-Object LastWriteTime -Descending
    if (-not $Files) {
        Write-Error "No SQL backup files found in $BackupDir"
        exit 1
    }

    Write-Host "Available Backups:" -ForegroundColor Cyan
    for ($i = 0; $i -lt $Files.Count; $i++) {
        Write-Host "[$i] $($Files[$i].Name) ($($Files[$i].LastWriteTime))"
    }

    $Selection = Read-Host "Select index to restore (0-$($Files.Count - 1))"
    if ($Selection -match "^\d+$" -and [int]$Selection -lt $Files.Count) {
        $BackupFile = $Files[[int]$Selection].FullName
    } else {
        Write-Error "Invalid selection."
        exit 1
    }
} else {
    # If a path was provided, ensure it exists
    if (-not (Test-Path $BackupFile)) {
        # Try finding it in the backups dir if only a filename was given
        $TryPath = Join-Path $BackupDir $BackupFile
        if (Test-Path $TryPath) {
            $BackupFile = $TryPath
        } else {
            Write-Error "Backup file not found: $BackupFile"
            exit 1
        }
    }
}

Write-Host "WARNING: This will overwrite the entire '$DbName' database with data from:" -ForegroundColor DarkRed
Write-Host "$BackupFile" -ForegroundColor Yellow
$Confirm = Read-Host "Are you sure you want to proceed? (yes/NO)"

if ($Confirm -ne "yes") {
    Write-Host "Restore cancelled." -ForegroundColor Gray
    exit 0
}

Write-Host "Starting restore to $DbName using $MysqlBin..." -ForegroundColor Yellow

# Construct mysql command
$RestoreCommand = "`"$MysqlBin`" --host=$DbHost --port=$DbPort --user=$DbUser --password=$DbPass $DbName"

# Execute
try {
    # Using mysql source command which is more robust than piping
    # This avoids PowerShell encoding issues with large files
    & "$MysqlBin" "--host=$DbHost" "--port=$DbPort" "--user=$DbUser" "--password=$DbPass" "$DbName" -e "source $BackupFile"
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Restore successful!" -ForegroundColor Green
    } else {
        Write-Error "mysql restore failed with exit code $LASTEXITCODE"
    }
} catch {
    Write-Error "An error occurred during restore: $($_.Exception.Message)"
}

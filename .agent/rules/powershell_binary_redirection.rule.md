# PowerShell Binary Redirection Safety

## Description
This rule prevents data corruption when redirecting output from external native binaries (e.g., `mysqldump`, `curl`, `git`) in PowerShell. It focuses on maintaining structural integrity, encoding, and line endings.

## Triggers
- Using PowerShell redirection operators (`>`, `>>`) with native commands.
- Using `Out-File` or `Set-Content` to capture output from an external process.
- Redirecting data that is line-based (SQL, CSV) or binary.

## Actions

### Prohibited
- **DO NOT** use `Out-File -NoNewline` when capturing output from external tools that produce line-based content (like SQL dumps). This can cause comments to invalidate the entire file.
- **DO NOT** rely on default encoding for redirection in Windows PowerShell (v5.1), as it defaults to UTF-16LE which many tools cannot read.
- **DO NOT** pipe binary output through the PowerShell object pipeline (`|`) unless using PowerShell 7.4+ with byte-stream preservation.

### Required
- **Encoding**: Always specify `-Encoding UTF8` (or `utf8NoBOM`) when using `Out-File` or `Set-Content` for compatibility.
- **Line Endings**: Ensure that redirection preserves newlines for formats that require them (like SQL).
- **Direct Redirection**: If possible, use the native command's own output flags (e.g., `mysqldump --result-file=...`) instead of PowerShell redirection.
- **Verification**: Always verify the first few bytes of a generated file (e.g., `Get-Content -Encoding Byte -TotalCount 4`) to ensure encoding matches expectations.

## Examples

### 🚫 Bad (Silent Corruption)
```powershell
# In Windows PowerShell, this creates a UTF-16 file with no newlines
& "mysqldump.exe" ... | Out-File "backup.sql" -NoNewline
```

### ✅ Good (Safe Redirection)
```powershell
# Preserves newlines and uses standard UTF8 encoding
& "mysqldump.exe" ... | Out-File "backup.sql" -Encoding UTF8
```

### ✅ Better (Native Flags)
```powershell
# Bypasses PowerShell redirection entirely
& "mysqldump.exe" "--result-file=backup.sql" ...
```

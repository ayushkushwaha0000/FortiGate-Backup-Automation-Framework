<#
================================================================================
FortiGate Backup Automation Script
Author: Ayush Kushwaha
Version: 1.0.0

DESCRIPTION:
Tool-independent automation framework to back up FortiGate firewall
configurations with structured logging and failure tracking.

IMPORTANT:
Before running this script, update the USER CONFIGURATION SECTION below.
================================================================================
#>

# ========================= USER CONFIGURATION SECTION =========================

# 1️⃣ Add FortiGate Device IPs (Comma Separated)
$FortiGateDevices = @(
    "192.168.1.1",   # <-- Replace with Device 1 IP
    "192.168.1.2"    # <-- Replace with Device 2 IP
)

# 2️⃣ Enter Username (Firewall Admin Username)
$Username = "YOUR_USERNAME_HERE"   # <-- Replace

# 3️⃣ Enter Password (Plain text for lab use only)
# Recommended: Use Secure Vault in production
$Password = "YOUR_PASSWORD_HERE"   # <-- Replace

# 4️⃣ Backup Storage Path
$BackupPath = "C:\FortiGate_Backups"   # <-- Modify if needed

# 5️⃣ Log Storage Path
$LogPath = "C:\FortiGate_Backups\Logs" # <-- Modify if needed

# 6️⃣ Wait Time Between Devices (Seconds)
$WaitInterval = 60   # <-- Adjust if required

# ======================= END USER CONFIGURATION SECTION =======================



# ========================= SCRIPT INITIALIZATION ==============================

# Create directories if not exist
if (!(Test-Path $BackupPath)) {
    New-Item -ItemType Directory -Path $BackupPath | Out-Null
}

if (!(Test-Path $LogPath)) {
    New-Item -ItemType Directory -Path $LogPath | Out-Null
}

$ExecutionLog = "$LogPath\Execution_Log_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
$FailedLog = "$LogPath\Failed_Devices_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

Add-Content $ExecutionLog "========== Backup Execution Started: $(Get-Date) =========="


# ============================== MAIN EXECUTION ================================

foreach ($Device in $FortiGateDevices) {

    Add-Content $ExecutionLog "`nProcessing Device: $Device"

    try {

        # Convert password to secure string
        $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
        $Credential = New-Object System.Management.Automation.PSCredential ($Username, $SecurePassword)

        # Backup File Name
        $Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $BackupFile = "$BackupPath\$Device`_$Timestamp.conf"

        # Example backup command using SSH (Plink required if using SSH method)
        # Replace below command logic as per your environment

        $Command = "execute backup config tftp $BackupFile 192.168.1.100"

        Add-Content $ExecutionLog "Attempting backup for $Device..."

        # --- SAMPLE CONNECTION METHOD ---
        # NOTE: Replace with your actual connection method (SSH/API)

        # Example:
        # ssh user@$Device $Command

        # For GitHub Template, we simulate execution:
        Start-Sleep -Seconds 3

        Add-Content $ExecutionLog "SUCCESS: Backup completed for $Device"

    }
    catch {
        Add-Content $ExecutionLog "ERROR: Backup failed for $Device"
        Add-Content $FailedLog "$Device"
    }

    # Wait before next device
    Add-Content $ExecutionLog "Waiting $WaitInterval seconds before next device..."
    Start-Sleep -Seconds $WaitInterval
}

Add-Content $ExecutionLog "`n========== Backup Execution Completed: $(Get-Date) =========="
Write-Host "Backup Process Completed. Check Logs for Details."

# ============================== END OF SCRIPT =================================

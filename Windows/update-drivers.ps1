# Save as: update-drivers.ps1
# Run as Administrator

Write-Host "Checking for driver updates..." -ForegroundColor Cyan

# Enable driver updates via Windows Update
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" -Name "SearchOrderConfig" -Value 1

# Start Windows Update scan
Write-Host "Scanning for updates (this includes drivers)..." -ForegroundColor Yellow
Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser

Import-Module PSWindowsUpdate

# Get all available updates
$updates = Get-WindowsUpdate -AcceptAll -IgnoreReboot

if ($updates.Count -eq 0) {
    Write-Host "No updates found." -ForegroundColor Green
} else {
    Write-Host "$($updates.Count) updates found. Installing..." -ForegroundColor Green
    # Install all updates including drivers
    Install-WindowsUpdate -AcceptAll -IgnoreReboot -AutoReboot
}

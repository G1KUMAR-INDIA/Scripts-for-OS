Write-Host "==========================================="
Write-Host "   Smart Windows + Browser Cleanup Tool"
Write-Host "==========================================="

# --- Function: Remove files safely ---
function Clear-Folder($path) {
    if (Test-Path $path) {
        try {
            Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
            Write-Host "Cleared: $path"
        } catch {
            Write-Host "Skipping (in use): $path"
        }
    }
}

# --- Windows Temp Cleanup ---
Write-Host "`nCleaning Windows Temp..."
Clear-Folder "$env:TEMP"
Clear-Folder "C:\Windows\Temp"

# --- Prefetch ---
Write-Host "`nCleaning Prefetch..."
Clear-Folder "C:\Windows\Prefetch"

# --- Windows Update Cache ---
Write-Host "`nCleaning Windows Update Cache..."
Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
Stop-Service bits -Force -ErrorAction SilentlyContinue
Clear-Folder "C:\Windows\SoftwareDistribution\Download"
Start-Service wuauserv -ErrorAction SilentlyContinue
Start-Service bits -ErrorAction SilentlyContinue

# --- Recycle Bin ---
Write-Host "`nEmptying Recycle Bin..."
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

# --- Windows Logs ---
Write-Host "`nCleaning Windows Logs..."
Clear-Folder "C:\Windows\Logs"
Clear-Folder "C:\ProgramData\Microsoft\Windows\WER"

# --- Delivery Optimization ---
Write-Host "`nCleaning Delivery Optimization..."
Clear-Folder "C:\Windows\SoftwareDistribution\DeliveryOptimization"

# --- Browser Cleanup ---
$browsers = @(
    @{ Name="Chrome";   Path="$env:LOCALAPPDATA\Google\Chrome\User Data\Default" },
    @{ Name="Edge";     Path="$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default" },
    @{ Name="Firefox";  Path="$env:APPDATA\Mozilla\Firefox\Profiles" },
    @{ Name="Brave";    Path="$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default" },
    @{ Name="Opera";    Path="$env:APPDATA\Opera Software\Opera Stable" }
)

foreach ($browser in $browsers) {
    if (Test-Path $browser.Path) {
        Write-Host "`nCleaning $($browser.Name)..."
        Clear-Folder "$($browser.Path)\Cache"
        Clear-Folder "$($browser.Path)\Code Cache"
        Clear-Folder "$($browser.Path)\GPUCache"
        Clear-Folder "$($browser.Path)\Local Storage"
        Remove-Item "$($browser.Path)\Cookies" -Force -ErrorAction SilentlyContinue
        Remove-Item "$($browser.Path)\History" -Force -ErrorAction SilentlyContinue
    } else {
        Write-Host "$($browser.Name) not installed."
    }
}

# --- DNS Flush ---
Write-Host "`nFlushing DNS..."
ipconfig /flushdns | Out-Null

# --- Microsoft Store Cache ---
Write-Host "`nCleaning Windows Store Cache..."
wsreset.exe

Write-Host "`n==========================================="
Write-Host " Full Cleanup Completed Successfully ✔"
Write-Host "==========================================="

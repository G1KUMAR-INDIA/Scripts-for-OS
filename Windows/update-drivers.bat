@echo off
:: Save as update-drivers.bat
:: Run as Administrator

echo ======================================
echo   Windows Driver Update Script
echo ======================================
echo.

:: Check if running as admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script must be run as Administrator.
    pause
    exit /b
)

:: Enable driver updates via Windows Update
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 1 /f >nul

echo Checking for driver updates... Please wait.

:: Call PowerShell directly
powershell -NoProfile -ExecutionPolicy Bypass -Command "Install-PackageProvider -Name NuGet -Force; Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser; Import-Module PSWindowsUpdate; Get-WindowsUpdate -MicrosoftUpdate -AcceptAll -Install -IgnoreReboot"

echo.
echo Driver update process completed.
pause

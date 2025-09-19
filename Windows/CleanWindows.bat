@echo off
echo ===========================================
echo     Cleaning Unnecessary Files in Windows
echo ===========================================

:: Clear user Temp files
echo Deleting User Temp Files...
del /q /f /s "%TEMP%\*" >nul 2>&1
for /d %%x in ("%TEMP%\*") do rd /s /q "%%x"

:: Clear system Temp files
echo Deleting Windows Temp Files...
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
for /d %%x in ("C:\Windows\Temp\*") do rd /s /q "%%x"

:: Clear Prefetch
echo Deleting Prefetch Files...
del /q /f /s "C:\Windows\Prefetch\*" >nul 2>&1

:: Clear Windows Update leftover cache
echo Deleting Windows Update Cache...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
for /d %%x in ("C:\Windows\SoftwareDistribution\Download\*") do rd /s /q "%%x"
net start wuauserv >nul 2>&1
net start bits >nul 2>&1

:: Clear Recycle Bin
echo Emptying Recycle Bin...
rd /s /q C:\$Recycle.Bin >nul 2>&1

:: Clear Windows Error Reporting
echo Deleting Windows Error Reporting files...
del /q /f /s "C:\ProgramData\Microsoft\Windows\WER\*" >nul 2>&1
for /d %%x in ("C:\ProgramData\Microsoft\Windows\WER\*") do rd /s /q "%%x"

:: Skip protected WaaSMedic logs
echo Skipping protected WaaSMedic logs (cannot be deleted)...

:: Clear Delivery Optimization files
echo Deleting Delivery Optimization Files...
del /q /f /s "C:\Windows\SoftwareDistribution\DeliveryOptimization\*" >nul 2>&1
for /d %%x in ("C:\Windows\SoftwareDistribution\DeliveryOptimization\*") do rd /s /q "%%x"

echo ===========================================
echo     Unnecessary Files Cleaned Successfully!
echo ===========================================
pause

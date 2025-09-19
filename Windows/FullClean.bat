@echo off
echo ===========================================
echo        Full Windows & Browser Cleaner
echo ===========================================

:: ==============================
:: Windows System Cleanup
:: ==============================
echo Deleting User Temp Files...
del /q /f /s "%TEMP%\*" >nul 2>&1
for /d %%x in ("%TEMP%\*") do rd /s /q "%%x"

echo Deleting Windows Temp Files...
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
for /d %%x in ("C:\Windows\Temp\*") do rd /s /q "%%x"

echo Deleting Prefetch Files...
del /q /f /s "C:\Windows\Prefetch\*" >nul 2>&1

echo Deleting Windows Update Cache...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
for /d %%x in ("C:\Windows\SoftwareDistribution\Download\*") do rd /s /q "%%x"
net start wuauserv >nul 2>&1
net start bits >nul 2>&1

echo Emptying Recycle Bin...
rd /s /q C:\$Recycle.Bin >nul 2>&1

echo Deleting Windows Error Reporting files...
del /q /f /s "C:\ProgramData\Microsoft\Windows\WER\*" >nul 2>&1
for /d %%x in ("C:\ProgramData\Microsoft\Windows\WER\*") do rd /s /q "%%x"

echo Skipping protected WaaSMedic logs...

echo Deleting Delivery Optimization Files...
del /q /f /s "C:\Windows\SoftwareDistribution\DeliveryOptimization\*" >nul 2>&1
for /d %%x in ("C:\Windows\SoftwareDistribution\DeliveryOptimization\*") do rd /s /q "%%x"

:: ==============================
:: Browser Cleanup
:: ==============================

:: Google Chrome
echo Cleaning Google Chrome Cache...
del /q /f /s "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*" >nul 2>&1
del /q /f /s "%LocalAppData%\Google\Chrome\User Data\Default\Code Cache\*" >nul 2>&1
del /q /f /s "%LocalAppData%\Google\Chrome\User Data\Default\GPUCache\*" >nul 2>&1

:: Microsoft Edge
echo Cleaning Microsoft Edge Cache...
del /q /f /s "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*" >nul 2>&1
del /q /f /s "%LocalAppData%\Microsoft\Edge\User Data\Default\Code Cache\*" >nul 2>&1
del /q /f /s "%LocalAppData%\Microsoft\Edge\User Data\Default\GPUCache\*" >nul 2>&1

:: Mozilla Firefox
echo Cleaning Mozilla Firefox Cache...
for /d %%x in ("%AppData%\Mozilla\Firefox\Profiles\*") do (
    del /q /f /s "%%x\cache2\entries\*" >nul 2>&1
)

:: ==============================
:: DNS & Store Cache
:: ==============================
echo Flushing DNS Cache...
ipconfig /flushdns

echo Clearing Windows Store Cache...
wsreset.exe

echo ===========================================
echo    Cleanup Completed Successfully! 🚀
echo ===========================================
pause

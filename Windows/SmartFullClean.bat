@echo off
echo ===========================================
echo     Smart Windows + Browser Cleanup Tool
echo ===========================================

:: ==============================
:: Windows System Cleanup
:: ==============================
echo Cleaning User Temp...
del /q /f /s "%TEMP%\*" >nul 2>&1
for /d %%x in ("%TEMP%\*") do rd /s /q "%%x"

echo Cleaning Windows Temp...
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
for /d %%x in ("C:\Windows\Temp\*") do rd /s /q "%%x"

echo Cleaning Prefetch...
del /q /f /s "C:\Windows\Prefetch\*" >nul 2>&1

echo Cleaning Windows Update Cache...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
for /d %%x in ("C:\Windows\SoftwareDistribution\Download\*") do rd /s /q "%%x"
net start wuauserv >nul 2>&1
net start bits >nul 2>&1

echo Emptying Recycle Bin...
rd /s /q C:\$Recycle.Bin >nul 2>&1

echo Skipping protected WaaSMedic logs...

echo Cleaning Delivery Optimization...
del /q /f /s "C:\Windows\SoftwareDistribution\DeliveryOptimization\*" >nul 2>&1
for /d %%x in ("C:\Windows\SoftwareDistribution\DeliveryOptimization\*") do rd /s /q "%%x"

:: ==============================
:: Browser Cleanup
:: ==============================

:: Google Chrome
if exist "%LocalAppData%\Google\Chrome\User Data" (
    echo Cleaning Google Chrome...
    rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache"
    rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Code Cache"
    rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\GPUCache"
    del /q /f "%LocalAppData%\Google\Chrome\User Data\Default\History"
    del /q /f "%LocalAppData%\Google\Chrome\User Data\Default\Cookies"
)

:: Microsoft Edge
if exist "%LocalAppData%\Microsoft\Edge\User Data" (
    echo Cleaning Microsoft Edge...
    rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache"
    rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Code Cache"
    rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\GPUCache"
    del /q /f "%LocalAppData%\Microsoft\Edge\User Data\Default\History"
    del /q /f "%LocalAppData%\Microsoft\Edge\User Data\Default\Cookies"
)

:: Mozilla Firefox
if exist "%AppData%\Mozilla\Firefox\Profiles" (
    echo Cleaning Mozilla Firefox...
    for /d %%x in ("%AppData%\Mozilla\Firefox\Profiles\*") do (
        rd /s /q "%%x\cache2"
        del /q /f "%%x\cookies.sqlite"
        del /q /f "%%x\places.sqlite"
    )
)

:: Opera Browser
if exist "%AppData%\Opera Software\Opera Stable" (
    echo Cleaning Opera Browser...
    rd /s /q "%AppData%\Opera Software\Opera Stable\Cache"
    del /q /f "%AppData%\Opera Software\Opera Stable\Cookies"
    del /q /f "%AppData%\Opera Software\Opera Stable\History"
)

:: Brave Browser
if exist "%LocalAppData%\BraveSoftware\Brave-Browser\User Data" (
    echo Cleaning Brave Browser...
    rd /s /q "%LocalAppData%\BraveSoftware\Brave-Browser\User Data\Default\Cache"
    rd /s /q "%LocalAppData%\BraveSoftware\Brave-Browser\User Data\Default\Code Cache"
    del /q /f "%LocalAppData%\BraveSoftware\Brave-Browser\User Data\Default\History"
    del /q /f "%LocalAppData%\BraveSoftware\Brave-Browser\User Data\Default\Cookies"
)

:: Vivaldi Browser
if exist "%LocalAppData%\Vivaldi\User Data" (
    echo Cleaning Vivaldi Browser...
    rd /s /q "%LocalAppData%\Vivaldi\User Data\Default\Cache"
    rd /s /q "%LocalAppData%\Vivaldi\User Data\Default\Code Cache"
    del /q /f "%LocalAppData%\Vivaldi\User Data\Default\History"
    del /q /f "%LocalAppData%\Vivaldi\User Data\Default\Cookies"
)

:: ==============================
:: DNS & Store Cache
:: ==============================
echo Flushing DNS Cache...
ipconfig /flushdns

echo Clearing Windows Store Cache...
wsreset.exe

echo ===========================================
echo   Full Cleanup Completed Successfully 🚀
echo ===========================================
pause

@echo off
echo ==========================================
echo   Windows Time Synchronization Fix Tool
echo ==========================================
echo.

echo Stopping Windows Time Service...
net stop w32time

echo Unregistering Windows Time Service...
w32tm /unregister

echo Registering Windows Time Service again...
w32tm /register

echo Configuring NTP server (time.nist.gov)...
w32tm /config /manualpeerlist:"time.nist.gov" /syncfromflags:manual /reliable:yes /update

echo Starting Windows Time Service...
net start w32time

echo Forcing resync with time server...
w32tm /resync /force

echo.
echo ==========================================
echo   Time synchronization reset completed!
echo   Please check your system clock now.
echo ==========================================
pause

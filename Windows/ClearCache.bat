@echo off
echo ===========================================
echo   Clearing All Cache in Windows PC
echo ===========================================

:: Clear Temp files
echo Deleting Temporary Files...
del /q /f /s "%TEMP%\*" >nul 2>&1
for /d %%x in ("%TEMP%\*") do rd /s /q "%%x"

:: Clear Windows Temp
echo Deleting Windows Temp...
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
for /d %%x in ("C:\Windows\Temp\*") do rd /s /q "%%x"

:: Clear Prefetch (speeds up next boot)
echo Deleting Prefetch Files...
del /q /f /s "C:\Windows\Prefetch\*" >nul 2>&1

:: Clear DNS cache
echo Flushing DNS Cache...
ipconfig /flushdns

:: Clear Microsoft Store cache
echo Clearing Windows Store Cache...
wsreset.exe

:: Clear Windows Update cache
echo Clearing Windows Update Cache...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
net start wuauserv >nul 2>&1
net start bits >nul 2>&1

:: Clear Recycle Bin
echo Emptying Recycle Bin...
rd /s /q C:\$Recycle.Bin >nul 2>&1

echo ===========================================
echo   All Cache Cleared Successfully!
echo ===========================================
pause

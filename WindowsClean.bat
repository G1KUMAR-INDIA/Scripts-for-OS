echo "Cleaning Your Windows"
del /q/f/s %temp%\*
sfc /scannow
echo  "Go to Run and type cleanmgr enter"
echo Clearing temporary files...
del /q/f/s %temp%\*.*
del /q/f/s %systemroot%\temp\*.*
echo Temporary files cleared.
echo.
pause
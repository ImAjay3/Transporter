@echo off
setlocal EnableDelayedExpansion

set SCRIPT_DIR=%~dp0
set "found="
set "IP="

echo Drag and drop folder to share:
set /p SHARE_PATH=
set SHARE_PATH=%SHARE_PATH:"=%

if not exist "%SHARE_PATH%" (
    echo Invalid path!
    pause
    exit /b
)

set /p PORT=Enter port (default 8000): 
if "%PORT%"=="" set PORT=8000

:: Get WiFi IP
for /f "tokens=1,* delims=:" %%a in ('ipconfig') do (
    echo %%a | findstr /c:"Wireless LAN adapter WiFi 2" >nul
    if not errorlevel 1 set "found=1"

    if defined found (
        echo %%a | findstr /c:"IPv4 Address" >nul
        if not errorlevel 1 (
            set "IP=%%b"
            set "IP=!IP:~1!"
            goto :done
        )
    )
)

:done

if "%IP%"=="" (
    echo Failed to detect WiFi IP!
    pause
    exit /b
)

set URL=http://%IP%:%PORT%

echo.
echo Sharing: %SHARE_PATH%
echo URL: %URL%
echo.

:: Start server in background
start /b cmd /c "cd /d "%SHARE_PATH%" && python -m http.server %PORT%"

:: Generate QR
python "%SCRIPT_DIR%qr.py" %URL%

echo.
echo Press any key to stop server...
pause >nul

:: Kill only this port
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :%PORT% ^| findstr LISTENING') do (
    set PID=%%a
)

if defined PID (
    taskkill /PID %PID% /f >nul 2>&1
)

echo Server stopped.
pause
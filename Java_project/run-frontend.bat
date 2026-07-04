@echo off
echo ========================================
echo   Starting Voting System Frontend
echo ========================================
echo.

cd /d "%~dp0\frontend"

echo Frontend will run on: http://localhost:5500
echo.
echo Press Ctrl+C to stop the server
echo.

python -m http.server 5500

if %errorlevel% neq 0 (
    echo.
    echo Trying python3...
    python3 -m http.server 5500
)

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Python not found!
    echo Please install Python or use VS Code Live Server
    pause
)

@echo off
echo ========================================
echo   Starting Voting System Backend
echo ========================================
echo.

cd /d "%~dp0"

echo [1/2] Checking database connection...
mysql -u root -e "USE voting_db; SELECT 1;" >nul 2>&1
if %errorlevel% neq 0 (
    echo WARNING: Could not connect to MySQL database
    echo Make sure XAMPP MySQL is running!
    echo.
    pause
)

echo [2/2] Starting Spring Boot backend server...
echo.
echo Backend will run on: http://localhost:8080
echo.
echo Press Ctrl+C to stop the server
echo.

mvn spring-boot:run

pause

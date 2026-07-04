@echo off
echo ========================================
echo   Voting System Setup Script
echo ========================================
echo.

echo [1/3] Checking Java installation...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Java is not installed or not in PATH
    echo Please install Java JDK 11 or higher
    pause
    exit /b 1
)
echo Java is installed ✓

echo.
echo [2/3] Checking Maven installation...
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Maven is not installed or not in PATH
    echo Please install Maven 3.6 or higher
    pause
    exit /b 1
)
echo Maven is installed ✓

echo.
echo [3/3] Building the project...
call mvn clean install -DskipTests
if %errorlevel% neq 0 (
    echo ERROR: Build failed
    pause
    exit /b 1
)
echo Build successful ✓

echo.
echo ========================================
echo   Setup Complete!
echo ========================================
echo.
echo Next Steps:
echo 1. Make sure XAMPP MySQL is running
echo 2. Import database/schema.sql into phpMyAdmin
echo 3. Run: mvn spring-boot:run
echo 4. Open frontend/index.html in your browser
echo.
pause

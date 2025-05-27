@echo off
REM ADS 509 Module 3: Automated Project Setup Script for Windows
REM This script automates the entire setup process for the text analysis project

setlocal enabledelayedexpansion

echo ==========================================
echo ADS 509 Module 3: Automated Setup
echo ==========================================
echo.

REM Check if Docker is installed
echo [INFO] Checking Docker installation...
docker --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Docker is not installed. Please install Docker Desktop first.
    echo Download from: https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

REM Check if Docker is running
echo [INFO] Checking if Docker is running...
docker info >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Docker is not running. Please start Docker Desktop.
    pause
    exit /b 1
)
echo [SUCCESS] Docker is installed and running

REM Check for data file
echo [INFO] Checking for data file...
if not exist "M1 Assignment Data (1).zip" (
    echo [ERROR] Data file 'M1 Assignment Data (1).zip' not found in current directory.
    echo.
    echo Please ensure the zip file is in the same directory as this script.
    echo You can download it from your course materials or assignment portal.
    pause
    exit /b 1
)
echo [SUCCESS] Data file found

REM Build Docker environment
echo [INFO] Building Docker environment...
docker compose build
if errorlevel 1 (
    echo [ERROR] Failed to build Docker environment
    pause
    exit /b 1
)
echo [SUCCESS] Docker environment built successfully

REM Stop any existing containers
echo [INFO] Stopping any existing containers...
docker compose down >nul 2>&1

REM Start services
echo [INFO] Starting services...
docker compose up -d
if errorlevel 1 (
    echo [ERROR] Failed to start services
    pause
    exit /b 1
)
echo [SUCCESS] Services started successfully

REM Wait for Jupyter to be ready
echo [INFO] Waiting for Jupyter Lab to be ready...
set /a attempts=0
:wait_loop
set /a attempts+=1
if %attempts% gtr 30 (
    echo [ERROR] Jupyter Lab failed to start within expected time
    pause
    exit /b 1
)

REM Try to connect to Jupyter
curl -s http://localhost:8889/lab >nul 2>&1
if errorlevel 1 (
    echo Waiting... ^(attempt %attempts%/30^)
    timeout /t 2 /nobreak >nul
    goto wait_loop
)
echo [SUCCESS] Jupyter Lab is ready

REM Extract data
echo [INFO] Extracting data files...
docker compose exec jupyter bash -c "cd /home/jovyan/work && bash docker/extract_data.sh"
if errorlevel 1 (
    echo [ERROR] Failed to extract data
    pause
    exit /b 1
)
echo [SUCCESS] Data extracted successfully

REM Verify setup
echo [INFO] Verifying setup...
docker compose exec jupyter bash -c "[ -d '/home/jovyan/work/M1 Results' ]" >nul 2>&1
if errorlevel 1 (
    echo [WARNING] Data directories not found - extraction may have failed
) else (
    echo [SUCCESS] Data directories created
)

docker compose exec jupyter bash -c "[ -f '/home/jovyan/work/Group Comparison copy.ipynb' ]" >nul 2>&1
if errorlevel 1 (
    echo [WARNING] Analysis notebook not found
) else (
    echo [SUCCESS] Analysis notebook found
)

REM Display completion message
echo.
echo ==========================================
echo [SUCCESS] Setup completed successfully!
echo ==========================================
echo.
echo Next steps:
echo 1. Open your web browser
echo 2. Navigate to: http://localhost:8889/lab
echo 3. Open 'Group Comparison copy.ipynb'
echo 4. Run the notebook cells to perform the analysis
echo.
echo To stop the environment later, run:
echo   docker compose down
echo.
echo To restart the environment, run:
echo   docker compose up -d
echo.

REM Open browser automatically
echo Opening Jupyter Lab in your default browser...
start http://localhost:8889/lab

pause

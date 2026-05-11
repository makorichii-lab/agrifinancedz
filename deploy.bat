@echo off
REM AgriFinance - GitHub & Vercel Deployment Setup Script

setlocal enabledelayedexpansion

echo.
echo ========================================
echo  AgriFinance Platform - Deploy Setup
echo ========================================
echo.

REM Check if git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Git is not installed or not in PATH
    echo Please install Git from: https://git-scm.com/download/win
    echo Then run this script again.
    pause
    exit /b 1
)

REM Check if npm is installed
npm --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js/npm is not installed
    echo Please install Node.js from: https://nodejs.org
    pause
    exit /b 1
)

echo [1/5] Installing dependencies...
call npm install
if errorlevel 1 (
    echo [ERROR] npm install failed
    pause
    exit /b 1
)

echo.
echo [2/5] Initialize Git repository...
git init
git add .
git commit -m "Initial commit - AgriFinance serverless platform"
if errorlevel 1 (
    echo [INFO] Git repository already initialized
)

echo.
echo [3/5] Setup Instructions:
echo.
echo STEP 1: Create a GitHub Repository
echo   1. Go to https://github.com/new
echo   2. Create a new repository named "agrifinance"
echo   3. Don't initialize with README
echo.
echo STEP 2: Add GitHub Remote and Push
echo   Run these commands:
echo   git remote add origin https://github.com/YOUR_USERNAME/agrifinance.git
echo   git branch -M main
echo   git push -u origin main
echo.
echo STEP 3: Create Neon PostgreSQL Database
echo   1. Go to https://neon.tech and sign up
echo   2. Create a new project
echo   3. Copy your DATABASE_URL connection string
echo   4. Run the SQL from database.sql in Neon's SQL editor
echo.
echo STEP 4: Deploy to Vercel
echo   1. Go to https://vercel.com/new
echo   2. Click "Import Project"
echo   3. Select your GitHub repository
echo   4. Add Environment Variables:
echo      - DATABASE_URL = Your Neon connection string
echo      - GEMINI_API_KEY = Your Gemini API key
echo   5. Click "Deploy"
echo.
echo STEP 5: After Deployment
echo   - Vercel will provide your app URL
echo   - Share that URL with others
echo   - All API calls are now serverless
echo.

echo [4/5] Building frontend...
call npm run build
if errorlevel 1 (
    echo [ERROR] Build failed
    pause
    exit /b 1
)

echo.
echo [5/5] Build complete!
echo.
echo Next steps:
echo 1. Push to GitHub using git commands above
echo 2. Set up Neon database and Vercel deployment
echo 3. Your app will be live at: https://your-project.vercel.app
echo.
echo For detailed instructions, see DEPLOYMENT.md
echo.
pause

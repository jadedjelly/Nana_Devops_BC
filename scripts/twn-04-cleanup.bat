@echo off
setlocal enabledelayedexpansion

:: Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo ❌ This script must be run as Administrator.
    pause
    exit /b
)

echo 🧹 Starting cleanup...

:: Uninstall Maven
choco uninstall -y maven

:: Uninstall Node.js
choco uninstall -y nodejs-lts

:: Remove Gradle manually
set GRADLE_DIR=C:\Gradle
if exist "%GRADLE_DIR%" (
    echo 🧹 Removing Gradle directory: %GRADLE_DIR%
    rmdir /S /Q "%GRADLE_DIR%"
) else (
    echo ✅ Gradle directory already removed or not found.
)

:: Remove Gradle from PATH
echo 🧹 Cleaning up PATH entry for Gradle...
setx PATH "%PATH:C:\Gradle\latest\bin;=%"

:: Optional: Uninstall base tools (if not needed elsewhere)
choco uninstall -y wget unzip curl

echo ✅ Cleanup completed.
pause

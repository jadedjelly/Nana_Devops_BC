@echo off
setlocal enabledelayedexpansion

:: Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo ❌ This script must be run as Administrator.
    pause
    exit /b
)

:: Install Chocolatey if not present
where choco >nul 2>&1
if %errorlevel% EQU 0 (
    echo ✅ Chocolatey is already installed.
) else (
    echo 📦 Installing Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
        "Set-ExecutionPolicy Bypass -Scope Process -Force; ^
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; ^
        iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    
    if %errorlevel% NEQ 0 (
        echo ❌ Chocolatey installation failed. Exiting...
        pause
        exit /b
    )
    echo ✅ Chocolatey installed successfully.
    refreshenv
)

echo 🔄 Updating system (Chocolatey)...
choco upgrade chocolatey -y

echo 📦 Installing base tools...
choco install -y wget unzip curl

:: 1. Maven
where mvn >nul 2>&1
if %errorlevel% EQU 0 (
    echo ✅ Maven is already installed. Skipping...
) else (
    echo 📦 Installing Maven...
    choco install -y maven
    call mvn -v | findstr "Apache Maven"
)

:: 2. Gradle
where gradle >nul 2>&1
if %errorlevel% EQU 0 (
    echo ✅ Gradle is already installed. Skipping...
) else (
    echo 📦 Installing Gradle...
    set GRADLE_VERSION=8.7
    set GRADLE_DIST=gradle-%GRADLE_VERSION%-bin.zip
    set GRADLE_URL=https://services.gradle.org/distributions/%GRADLE_DIST%

    powershell -Command "Invoke-WebRequest -Uri %GRADLE_URL% -OutFile $env:TEMP\%GRADLE_DIST%"
    powershell -Command "Expand-Archive -LiteralPath $env:TEMP\%GRADLE_DIST% -DestinationPath 'C:\Gradle'"
    mklink /D C:\Gradle\latest C:\Gradle\gradle-%GRADLE_VERSION%

    setx PATH "%PATH%;C:\Gradle\latest\bin"
    echo ✅ Gradle installed:
    call gradle -v | findstr "Gradle"
)

:: 3. Node.js and npm
where npm >nul 2>&1
if %errorlevel% EQU 0 (
    echo ✅ npm is already installed. Skipping...
) else (
    echo 📦 Installing Node.js and npm...
    choco install -y nodejs-lts
    call node -v
    call npm -v
)

echo ✅ All requested tools are now installed or were already present.
pause

@echo off
setlocal enabledelayedexpansion

title Development Tools Installer
echo ========================================
echo ===  Development Tools Installer       ===
echo ========================================
echo.

:: Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo This script requires administrator privileges.
    set /p adminChoice="Would you like to relaunch as Administrator? (Y/N): "
    if /I "%adminChoice%"=="Y" (
        powershell -Command "Start-Process '%~f0' -Verb RunAs"
    ) else (
        echo Exiting. Please run this script as Administrator.
    )
    pause
    exit /b
)

:: STEP 1: Install Chocolatey
echo [1/7] Checking Chocolatey...
where choco >nul 2>&1
if %errorlevel% EQU 0 (
    echo Chocolatey is already installed.
) else (
    echo Installing Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    if %errorlevel% NEQ 0 (
        echo Chocolatey installation failed.
        pause
        exit /b
    )
    echo Chocolatey installed successfully.
)
echo.

:: STEP 2: Upgrade Chocolatey
echo [2/7] Updating Chocolatey...
choco upgrade chocolatey -y
echo Chocolatey upgraded.
echo.

:: STEP 3: Install Base Tools
echo [3/7] Installing base tools (wget, unzip, curl)...
choco install -y wget unzip curl
echo Base tools installed.
echo.

:: STEP 4: Install Java JDK and Set JAVA_HOME
echo [4/7] Checking Java...
where java >nul 2>&1
if %errorlevel% EQU 0 (
    echo Java is already installed.
) else (
    echo Installing Temurin OpenJDK 17...
    choco install -y temurin17
)

:: Set JAVA_HOME based on where Temurin was installed
for /f "tokens=2,*" %%A in ('reg query "HKLM\SOFTWARE\Eclipse Adoptium" /s /f "JavaHome" ^| findstr /i "JavaHome"') do (
    set "JAVA_HOME=%%B"
    setx JAVA_HOME "%%B"
    echo JAVA_HOME set to %%B
)
echo.

:: Try to set JAVA_HOME
echo Setting JAVA_HOME...
for /f "tokens=2,*" %%A in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s /f "OpenJDK" ^| findstr /i "InstallLocation"') do (
    set "JAVA_HOME=%%B"
    setx JAVA_HOME "%%B"
    echo JAVA_HOME set to %%B
)
echo.

:: STEP 5: Install Maven
echo [5/7] Checking Maven...
where mvn >nul 2>&1
if %errorlevel% EQU 0 (
    echo Maven is already installed.
) else (
    echo Installing Maven...
    choco install -y maven
    call mvn -v | findstr "Apache Maven"
    echo Maven installed.
)
echo.

:: STEP 6: Install Gradle 8.7 manually
echo [6/7] Checking Gradle...
where gradle >nul 2>&1
if %errorlevel% EQU 0 (
    echo Gradle is already installed.
) else (
    echo Installing Gradle 8.7...

    setlocal enabledelayedexpansion
    set "GRADLE_VERSION=8.7"
    set "GRADLE_DIST=gradle-!GRADLE_VERSION!-bin.zip"
    set "GRADLE_URL=https://services.gradle.org/distributions/!GRADLE_DIST!"
    set "GRADLE_TEMP=%TEMP%\!GRADLE_DIST!"

    echo Downloading from: !GRADLE_URL!
    powershell -NoProfile -Command "Invoke-WebRequest -Uri '!GRADLE_URL!' -OutFile '!GRADLE_TEMP!'"

    if exist "!GRADLE_TEMP!" (
        echo Extracting to C:\Gradle...
        powershell -NoProfile -Command "Expand-Archive -LiteralPath '!GRADLE_TEMP!' -DestinationPath 'C:\Gradle' -Force"

        if exist "C:\Gradle\latest" (
            rmdir /S /Q "C:\Gradle\latest"
        )
        mklink /D C:\Gradle\latest C:\Gradle\gradle-!GRADLE_VERSION!

        echo Adding Gradle to PATH...
        setx PATH "%PATH%;C:\Gradle\latest\bin"

        echo Gradle installed:
        call C:\Gradle\latest\bin\gradle.bat -v | findstr "Gradle"
    ) else (
        echo Failed to download Gradle ZIP.
    )
    endlocal
)
echo.

:: STEP 7: Install Node.js and npm
echo [7/7] Checking Node.js and npm...
where npm >nul 2>&1
if %errorlevel% EQU 0 (
    echo Node.js and npm are already installed.
) else (
    echo Installing Node.js LTS...
    choco install -y nodejs-lts
    call node -v
    call npm -v
    echo Node.js and npm installed.
)
echo.

:: DONE
echo ----------------------------------------
echo All requested tools are now installed.
echo You may need to restart your terminal or system for PATH changes to take effect.
pause

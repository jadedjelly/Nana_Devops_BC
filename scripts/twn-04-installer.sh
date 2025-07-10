#!/bin/bash

set -e

echo "🔄 Updating system packages..."
sudo apt update -y
sudo apt upgrade -y

echo "📦 Installing base tools..."
sudo apt install -y wget unzip curl gnupg2 ca-certificates apt-transport-https software-properties-common

### 1. Maven
if command -v mvn &> /dev/null; then
    echo "✅ Maven is already installed. Skipping..."
else
    echo "📦 Installing Maven..."
    sudo apt install -y maven
    echo "✅ Maven installed: $(mvn -v | head -n 1)"
fi

### 2. Gradle
if command -v gradle &> /dev/null; then
    echo "✅ Gradle is already installed. Skipping..."
else
    echo "📦 Installing Gradle..."
    GRADLE_VERSION=8.7
    GRADLE_DIST=gradle-${GRADLE_VERSION}-bin.zip
    GRADLE_URL=https://services.gradle.org/distributions/${GRADLE_DIST}

    wget -q ${GRADLE_URL} -P /tmp
    sudo unzip -d /opt/gradle /tmp/${GRADLE_DIST}
    sudo ln -sfn /opt/gradle/gradle-${GRADLE_VERSION} /opt/gradle/latest

    # Add to PATH
    if ! grep -q "/opt/gradle/latest/bin" ~/.bashrc; then
        echo 'export PATH=$PATH:/opt/gradle/latest/bin' >> ~/.bashrc
    fi
    export PATH=$PATH:/opt/gradle/latest/bin

    echo "✅ Gradle installed: $(gradle -v | grep Gradle)"
fi

### 3. Node.js and npm
if command -v npm &> /dev/null; then
    echo "✅ npm is already installed. Skipping..."
else
    echo "📦 Installing Node.js and npm..."
    NODE_VERSION=20
    curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash -
    sudo apt install -y nodejs

    echo "✅ Node installed: $(node -v)"
    echo "✅ npm installed: $(npm -v)"
fi

echo "✅ All requested tools are now installed or were already present."


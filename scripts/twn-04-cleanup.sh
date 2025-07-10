#!/bin/bash

echo "Starting cleanup of Maven, Gradle, and npm..."

# Remove Maven
echo "Removing Maven..."
sudo apt purge --auto-remove -y maven

# Remove Gradle (manual installation in /opt)
echo "Removing Gradle..."
sudo rm -rf /opt/gradle
sudo sed -i '/\/opt\/gradle\/latest\/bin/d' ~/.bashrc
source ~/.bashrc

# Remove npm and Node.js (from NodeSource)
echo "Removing Node.js and npm..."
sudo apt purge --auto-remove -y nodejs

# Clean up any residual config/packages
echo "Cleaning up apt cache and config files..."
sudo apt autoremove -y
sudo apt clean

echo "Cleanup complete."


#!/bin/bash

# Nginx Installation and Setup
# Description: This script installs and configures Nginx on Ubuntu.


# Step 1: Update Package List
echo "Updating package lists..."
sudo apt update -y

# Step 2: Install Nginx
echo "Installing Nginx..."
sudo apt install -y nginx

# Step 3: Start and Enable Nginx Service
echo "Starting and enabling Nginx service..."
sudo systemctl start nginx
sudo systemctl enable nginx

# Step 4: Create a Default Web Page
echo "Creating a default web page..."
echo "<h1>Nginx Web Server is Running</h1>" | sudo tee /var/www/html/index.html

# Step 5: Verify Nginx Status
echo "Checking Nginx service status..."
sudo systemctl status nginx

echo "Nginx installation and setup completed successfully."


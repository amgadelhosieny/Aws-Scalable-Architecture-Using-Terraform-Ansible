#!/bin/bash
sudo apt update -y
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<h1>Nginx Web Server is Running</h1>" | sudo tee /var/www/html/index.html

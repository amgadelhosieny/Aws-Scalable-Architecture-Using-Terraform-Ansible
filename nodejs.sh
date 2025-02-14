#!/bin/bash

# Update and upgrade system packages
sudo apt update && sudo apt upgrade -y

# Install Node.js 20.x
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Verify installation
node -v
npm -v

# Create the application directory
sudo mkdir -p /home/ubuntu/app
cd /home/ubuntu/app


# Initialize a Node.js project with default settings
sudo npm init -y

# Install Express.js
sudo npm install express

# Create server.js with predefined content
cat <<EOF | sudo tee server.js
const express = require('express');
const app = express();

// Define the port (default: 3000)
const PORT = process.env.PORT || 3000;

// Define a simple route
app.get('/health', (req, res) => {
    res.send('Hello, Express.js is running!');
});

// Start the server
app.listen(PORT, () => {
    console.log(\`Server is running on http://localhost:\${PORT}\`);
});
EOF

# Provide execution feedback
echo "Setup complete. To run the server, use: node server.js"

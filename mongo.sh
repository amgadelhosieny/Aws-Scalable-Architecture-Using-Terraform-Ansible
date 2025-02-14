#!/bin/bash

# Update system packages
sudo apt update -y


# Install dependencies
sudo apt-get install gnupg curl

# Install dependencies
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor

# Add MongoDB repository   
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list

# Update package lists again
sudo apt-get update

# Install MongoDB
sudo apt-get install -y mongodb-org

# Enable and start MongoDB service
sudo systemctl start mongod
sudo systemctl daemon-reload

# Configure MongoDB for replication
sudo tee /etc/mongod.conf > /dev/null <<EOF
storage:
  dbPath: /var/lib/mongodb
  journal:
    enabled: true
systemLog:
  destination: file
  path: /var/log/mongodb/mongod.log
  logAppend: true
net:
  bindIp: 0.0.0.0
  port: 27017
replication:
  replSetName: "rs0"
EOF

# Restart MongoDB to apply changes
sudo systemctl restart mongod

# Wait for MongoDB to fully start
sleep 10

# Initialize Replica Set (Run on the PRIMARY Node Only)
if [[ $(hostname) == "mongo-primary" ]]; then
    mongo --eval 'rs.initiate({
      _id: "rs0",
      members: [
        { _id: 0, host: "mongo-primary:27017" },
        { _id: 1, host: "mongo-secondary-1:27017" },
        { _id: 2, host: "mongo-secondary-2:27017" }
      ]
    })'
fi




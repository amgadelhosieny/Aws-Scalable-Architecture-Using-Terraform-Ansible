#!/bin/bash
# Description: This script installs MongoDB, configures replication, and sets up a replica set.

# Step 1: Import MongoDB GPG Key
echo "Adding MongoDB GPG Key..."
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor

# Step 2: Add MongoDB Repository
echo "Adding MongoDB Repository..."
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/8.0 multiverse" | \
sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list

# Step 3: Update and Install MongoDB
echo "Updating package lists..."
sudo apt-get update

echo "Installing MongoDB..."
sudo apt-get install -y mongodb-org

# Step 4: Start and Enable MongoDB Service
echo "Starting MongoDB service..."
sudo systemctl start mongod
sudo systemctl enable mongod

# Step 5: Configure MongoDB for Replication
echo "Configuring MongoDB replication..."
sudo cp /etc/mongod.conf /etc/mongod.conf.backup

echo "Updating mongod.conf..."
sudo tee /etc/mongod.conf > /dev/null <<EOF
# MongoDB Configuration File
storage:
  dbPath: /var/lib/mongodb
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log
net:
  port: 27017
  bindIp: 0.0.0.0
processManagement:
  timeZoneInfo: /usr/share/zoneinfo
replication:
  replSetName: "rs0"
EOF

# Step 6: Restart MongoDB Service
echo "Restarting MongoDB service..."
sudo systemctl restart mongod

# Step 7: Initialize Replica Set
echo "Initializing Replica Set..."
mongosh 'rs.initiate({
  _id: "rs0",
  members: [
    { _id: 0, host: "10.0.5.130:27017" },
    { _id: 1, host: "10.0.5.170:27017" },
    { _id: 2, host: "10.0.6.178:27017" }
  ]
})'

# Step 8: Verify Replica Set Status
echo "Checking Replica Set Status..."
mongosh 'rs.status()'
mongosh 'rs.conf()'

# Step 9: Insert Test Data
echo "Inserting test data into testdb..."
mongosh 'use testdb; db.testCollection.insertOne({ name: "MongoDB Replication Test" })'

echo "MongoDB Replica Set Setup Completed Successfully."

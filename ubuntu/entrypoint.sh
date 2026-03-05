#!/bin/bash

set -e

echo "Updating packages..."
apt-get update -y

echo "Installing dependencies..."
apt-get install -y wget tar curl

echo "Downloading Node Exporter..."
cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v1.10.2/node_exporter-1.10.2.linux-amd64.tar.gz

echo "Extracting..."
tar -xvf node_exporter-1.10.2.linux-amd64.tar.gz

echo "Starting Node Exporter..."
cd node_exporter-1.10.2.linux-amd64

./node_exporter
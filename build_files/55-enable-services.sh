#!/usr/bin/env bash
set -euo pipefail

echo "Enabling custom flatpaks service..."

# Make the script executable
chmod +x /usr/local/bin/install-custom-flatpaks.sh

# Enable the service globally for all users
systemctl --global enable custom-flatpaks.service

echo "Custom flatpaks service enabled!"
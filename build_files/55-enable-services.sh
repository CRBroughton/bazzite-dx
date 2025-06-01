#!/usr/bin/env bash
set -euo pipefail

echo "Enabling custom flatpaks service..."

# Enable the service globally for all users
systemctl --global enable custom-flatpaks.service

echo "Custom flatpaks service enabled!"
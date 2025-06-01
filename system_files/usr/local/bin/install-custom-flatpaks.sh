#!/usr/bin/bash
set -euo pipefail

echo "Installing custom Flatpaks..."

# Add flathub repo
flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Flatpaks directly (no external file needed)
flatpak install --system --noninteractive --assumeyes flathub \
    com.discordapp.Discord \
    md.obsidian.Obsidian \
    com.bitwarden.desktop \
    org.gnome.World.PikaBackup/x86_64/stable \
    org.qbittorrent.qBittorrent \
    com.spotify.Client

# Create marker file so it only runs once
touch /var/lib/custom-flatpaks-installed

echo "Custom Flatpaks installed successfully!"
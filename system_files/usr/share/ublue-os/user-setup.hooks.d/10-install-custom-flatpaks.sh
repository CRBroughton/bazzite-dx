#!/usr/bin/bash
set -euo pipefail

echo "Installing custom Flatpaks..."

# Add flathub repo
flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Flatpaks directly (no external file needed)
flatpak install --system --noninteractive --assumeyes flathub \
    com.discordapp.Discord \
    md.obsidian.Obsidian \
    org.libreoffice.LibreOffice \
    com.bitwarden.desktop

echo "Custom Flatpaks installed successfully!"
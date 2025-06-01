#!/usr/bin/bash
echo "Installing custom Flatpaks..."
flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo
FLATPAK_LIST="$(cat /etc/ublue-os/custom | tr '\n' ' ')"
flatpak --system -y install flathub ${FLATPAK_LIST}
echo "Custom Flatpaks installed successfully!"
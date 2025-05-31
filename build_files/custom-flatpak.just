# vim: set ft=make :

# Install user specified flatpaks (post-install)
install-custom-flatpaks:
    #!/usr/bin/bash
    echo "Installing custom Flatpaks..."
    flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo
    FLATPAK_LIST="$(cat /etc/ublue-os/custom_Flatpaks | tr '\n' ' ')"
    flatpak --system -y install flathub ${FLATPAK_LIST}
    echo "Custom Flatpaks installed successfully!"
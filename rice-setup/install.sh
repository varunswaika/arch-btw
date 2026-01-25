#!/bin/bash

# This is the main installation script for the rice-setup.

echo "Starting the rice-setup installation..."

# Get the directory of this script
INSTALL_ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# Run the installation scripts
source "$INSTALL_ROOT/install/install-packages.sh"
source "$INSTALL_ROOT/install/install-drivers.sh"
source "$INSTALL_ROOT/install/setup-ly.sh"
source "$INSTALL_ROOT/install/setup-zsh.sh"
source "$INSTALL_ROOT/install/stow-setup.sh"
source "$INSTALL_ROOT/install/setup-bat.sh"
source "$INSTALL_ROOT/install/setup-grub.sh"
source "$INSTALL_ROOT/install/setup-icons.sh"
source "$INSTALL_ROOT/install/setup-gtk.sh"
source "$INSTALL_ROOT/install/setup-fonts.sh"
source "$INSTALL_ROOT/install/install-lazyvim.sh"

echo "Installation complete!"
echo "Please reboot your system."
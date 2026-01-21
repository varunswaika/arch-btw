#!/bin/bash

# This is the main installation script for the rice-setup.

echo "Starting the rice-setup installation..."

# Get the directory of this script
INSTALL_ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

# Run the installation scripts
source "$INSTALL_ROOT/install/install-packages.sh"
source "$INSTALL_ROOT/install/install-drivers.sh"
source "$INSTALL_ROOT/install/install-language.sh"
source "$INSTALL_ROOT/install/stow-setup.sh"

echo "Installation complete!"
echo "Please reboot your system."
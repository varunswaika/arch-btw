#!/bin/bash

# This script installs all the packages.

# Get the directory of the script (rice-setup/install)
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
# The root of the repo (Rice)
REPO_ROOT=$(dirname "$(dirname "$SCRIPT_DIR")")

# Install yay if it's not already installed
source "$SCRIPT_DIR/install-yay.sh"

# Install all the packages from the pacman-packages.txt file
echo "Installing packages..."
sudo pacman -Sy
sed 's/#.*//' "$REPO_ROOT/rice-setup/pacman-packages.txt" | xargs yay -S --noconfirm --needed

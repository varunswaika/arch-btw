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
sed 's/#.*//' "$REPO_ROOT/rice-setup/packages/pacman-packages.txt" | xargs yay -S --noconfirm --needed

# Install SDDM Theme
echo "Installing SDDM Theme..."
sudo mkdir -p /usr/share/sddm/themes/rose-pine
sudo cp -r "$REPO_ROOT/rice-setup/sddm-theme/"* /usr/share/sddm/themes/rose-pine/

# Configure SDDM
echo "Configuring SDDM..."
sudo mkdir -p /etc/sddm.conf.d
echo "[Theme]
Current=rose-pine" | sudo tee /etc/sddm.conf.d/theme.conf

# Enable SDDM
echo "Enabling SDDM..."
sudo systemctl enable sddm

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

#!/bin/bash

# This script sets up the Ly Display Manager.

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
REPO_ROOT=$(dirname "$(dirname "$SCRIPT_DIR")")

# Remove SDDM if installed (from archinstall)
if pacman -Qi sddm &> /dev/null; then
    echo "Removing SDDM..."
    sudo systemctl disable --now sddm 2>/dev/null
    sudo pacman -Rns --noconfirm sddm
fi

# Configure Ly Display Manager
echo "Configuring Ly Display Manager..."

# Symlink Ly config from dotfiles
LY_CONFIG_SRC="$REPO_ROOT/rice-setup/dotfiles/.config/ly/config.ini"
LY_CONFIG_DEST="/etc/ly/config.ini"

if [ -f "$LY_CONFIG_SRC" ]; then
    echo "Symlinking Ly configuration..."
    if [ -f "$LY_CONFIG_DEST" ] && [ ! -L "$LY_CONFIG_DEST" ]; then
        sudo mv "$LY_CONFIG_DEST" "${LY_CONFIG_DEST}.bak"
    fi
    sudo mkdir -p "$(dirname "$LY_CONFIG_DEST")"
    sudo ln -sf "$LY_CONFIG_SRC" "$LY_CONFIG_DEST"
else
    echo "Warning: Ly config source file not found at $LY_CONFIG_SRC"
fi

# Enable Ly
echo "Enabling Ly..."
sudo systemctl disable getty@tty2.service 2>/dev/null
sudo systemctl enable ly.service

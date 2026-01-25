#!/bin/bash

# This script uses stow to create symlinks for the dotfiles.
cd "$(dirname "$0")/../dotfiles" || exit 1

echo "Stowing dotfiles..."
stow -t "$HOME" .

# Stow GRUB theme to system directory (requires sudo)
# We invoke stow explicitly on 'grub' to override the .stow-local-ignore in the root
if [ -d "/usr/share/grub/themes" ]; then
    echo "Stowing GRUB theme to /usr/share/grub/themes..."
    sudo mkdir -p /usr/share/grub/themes
    sudo stow -t /usr/share/grub/themes grub
else
    echo "Directory /usr/share/grub/themes does not exist, creating it..."
    sudo mkdir -p /usr/share/grub/themes
    sudo stow -t /usr/share/grub/themes grub
fi

echo "Dotfiles have been stowed."
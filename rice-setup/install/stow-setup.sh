#!/bin/bash

# This script uses stow to create symlinks for the dotfiles.
SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
DOTFILES_DIR="$SCRIPT_DIR/../dotfiles"

# Ensure we are in the dotfiles directory
cd "$DOTFILES_DIR" || exit 1

# --- Conflict Resolution ---
echo "Checking for conflicts..."

# We iterate over all files we intend to stow.
# If a real file (not a symlink) exists at the target, we remove it.
find . -type f | while read -r file; do
    # Strip leading ./
    rel_path="${file#./}"
    target_path="$HOME/$rel_path"

    if [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
        echo "  Conflict found. Removing existing file: $rel_path"
        rm -rf "$target_path"
    fi
done

# --- Main Stow ---
echo "Stowing dotfiles..."
stow -t "$HOME" .

# --- GRUB Theme ---
# Stow GRUB theme to system directory (requires sudo)
# We invoke stow explicitly on 'grub' to override the .stow-local-ignore in the root
TARGET_GRUB_DIR="/usr/share/grub/themes"

if [ ! -d "$TARGET_GRUB_DIR" ]; then
    echo "Directory $TARGET_GRUB_DIR does not exist, creating it..."
    sudo mkdir -p "$TARGET_GRUB_DIR"
fi

echo "Stowing GRUB theme to $TARGET_GRUB_DIR..."
# For system files, we'll be more cautious but still follow the "remove" instruction
# if there's a conflict within the specific grub theme directory.
sudo stow -t "$TARGET_GRUB_DIR" grub

echo "Dotfiles have been stowed."
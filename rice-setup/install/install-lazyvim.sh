#!/bin/bash

# This script installs LazyVim.

# Check if nvim is installed
if ! command -v nvim &> /dev/null
then
    echo "Neovim (nvim) is not installed. Please install it first."
    exit 1
fi

echo "Installing LazyVim..."

# Backup existing Neovim configuration
if [ -d "$HOME/.config/nvim" ]; then
    echo "Backing up existing Neovim configuration to ~/.config/nvim.bak"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
fi

if [ -d "$HOME/.local/share/nvim" ]; then
    echo "Backing up existing Neovim local share to ~/.local/share/nvim.bak"
    mv "$HOME/.local/share/nvim" "$HOME/.local/share/nvim.bak"
fi

if [ -d "$HOME/.local/state/nvim" ]; then
    echo "Backing up existing Neovim local state to ~/.local/state/nvim.bak"
    mv "$HOME/.local/state/nvim" "$HOME/.local/state/nvim.bak"
fi

if [ -d "$HOME/.cache/nvim" ]; then
    echo "Backing up existing Neovim cache to ~/.cache/nvim.bak"
    mv "$HOME/.cache/nvim" "$HOME/.cache/nvim.bak"
fi

# Clone LazyVim starter
echo "Cloning LazyVim starter..."
git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"

# Remove the .git directory so you can add it to your own repo later
rm -rf "$HOME/.config/nvim/.git"

echo "LazyVim installation complete!"

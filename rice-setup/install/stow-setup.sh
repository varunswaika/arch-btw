#!/bin/bash

# This script uses stow to create symlinks for the dotfiles.
cd "$(dirname "$0")/../stow-packages"

echo "Stowing dotfiles..."
stow -t "$HOME" .

# Change default shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh..."
    chsh -s "$(which zsh)"
fi

# If plymouth is added as a system package later:
# sudo stow -t / plymouth
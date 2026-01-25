#!/bin/bash

# This script sets up 'bat' (cat clone with wings).
# It assumes dotfiles have already been stowed to ~/.config/bat

echo "Setting up bat..."

if command -v bat &> /dev/null; then
    echo "Rebuilding bat cache..."
    bat cache --build
    echo "bat cache rebuilt."
else
    echo "Warning: bat is not installed. Skipping cache rebuild."
fi

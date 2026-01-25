#!/bin/bash

# This script configures the Papirus icon theme with Catppuccin colors.

echo "Configuring Papirus folders to Catppuccin Mocha Maroon..."

# Apply the Catppuccin Mocha Maroon flavor to the Papirus-Dark theme
# This requires sudo because the icons are installed in /usr/share/icons
sudo papirus-folders -C cat-mocha-maroon --theme Papirus-Dark

echo "Papirus folders configured."

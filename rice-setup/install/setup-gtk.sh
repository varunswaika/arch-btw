#!/bin/bash

# This script sets up the GTK theme and GTK4 symlinks.
# It assumes catppuccin-gtk-theme-mocha is installed via AUR.

# Using Maroon accent to match setup-icons.sh
FLAVOR="Mocha"
ACCENT="Maroon"
THEME_NAME="Catppuccin-$FLAVOR-Standard-$ACCENT-Dark"
THEME_DIR_SYSTEM="/usr/share/themes/$THEME_NAME"
THEME_DIR_LOCAL="${HOME}/.themes/$THEME_NAME"

echo "Configuring GTK theme: $THEME_NAME"

# Check if the preferred theme exists in either location
if [ -d "$THEME_DIR_LOCAL" ]; then
    THEME_DIR="$THEME_DIR_LOCAL"
elif [ -d "$THEME_DIR_SYSTEM" ]; then
    THEME_DIR="$THEME_DIR_SYSTEM"
else
    echo "Warning: $THEME_NAME not found in /usr/share/themes/ or ~/.themes/"
    # Try to find any Mocha variant in either location
    ANY_MOCHA=$(ls -d ${HOME}/.themes/Catppuccin-Mocha-* /usr/share/themes/Catppuccin-Mocha-* 2>/dev/null | head -n 1)
    if [ -n "$ANY_MOCHA" ]; then
        THEME_DIR="$ANY_MOCHA"
        THEME_NAME=$(basename "$THEME_DIR")
        echo "Found alternative: $THEME_NAME"
    else
        echo "Error: No Catppuccin-Mocha GTK theme found."
        echo "Please ensure catppuccin-gtk-theme-mocha is installed via AUR or built from source."
        exit 1
    fi
fi

# Apply theme for GTK3 applications
if command -v gsettings >/dev/null; then
    echo "Applying theme via gsettings..."
    gsettings set org.gnome.desktop.interface gtk-theme "$THEME_NAME"
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
else
    echo "gsettings not found, skipping GTK3 configuration."
fi

# Apply theme for GTK4 (Libadwaita) applications via symlinks
echo "Setting up GTK4 symlinks for Libadwaita..."
mkdir -p "${HOME}/.config/gtk-4.0"
ln -sf "${THEME_DIR}/gtk-4.0/assets" "${HOME}/.config/gtk-4.0/assets"
ln -sf "${THEME_DIR}/gtk-4.0/gtk.css" "${HOME}/.config/gtk-4.0/gtk.css"
ln -sf "${THEME_DIR}/gtk-4.0/gtk-dark.css" "${HOME}/.config/gtk-4.0/gtk-dark.css"

echo "GTK setup complete."

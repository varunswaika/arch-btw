#!/bin/bash
set -e

echo "Configuring Catppuccin GRUB Theme..."

# Check if the theme exists (should be installed by stow-setup.sh)
THEME_NAME="catppuccin-mocha-grub-theme"
THEME_PATH="/usr/share/grub/themes/$THEME_NAME/theme.txt"

if [ ! -f "$THEME_PATH" ]; then
    echo "Error: Theme not found at $THEME_PATH"
    echo "Please run install/stow-setup.sh first."
    exit 1
fi

# Configure GRUB to use the Mocha theme
GRUB_CONFIG="/etc/default/grub"

if [ -f "$GRUB_CONFIG" ];
    then
    echo "Configuring $GRUB_CONFIG..."
    
    # Backup the config
    sudo cp "$GRUB_CONFIG" "$GRUB_CONFIG.bak"

    # Update GRUB_THEME
    if grep -q "^GRUB_THEME=" "$GRUB_CONFIG"; then
        sudo sed -i "s|^GRUB_THEME=.*|GRUB_THEME=\"$THEME_PATH\"|" "$GRUB_CONFIG"
    else
        echo "GRUB_THEME=\"$THEME_PATH\"" | sudo tee -a "$GRUB_CONFIG"
    fi

    # Ensure GRUB_TERMINAL_OUTPUT is commented out (as per README)
    sudo sed -i 's|^GRUB_TERMINAL_OUTPUT="console"|# GRUB_TERMINAL_OUTPUT="console"|' "$GRUB_CONFIG"

    # Update GRUB
    echo "Updating GRUB configuration..."
    if command -v grub-mkconfig &> /dev/null;
        then
        sudo grub-mkconfig -o /boot/grub/grub.cfg
    elif command -v grub2-mkconfig &> /dev/null;
        then
        sudo grub2-mkconfig -o /boot/grub2/grub.cfg
    else
        echo "Error: grub-mkconfig not found."
    fi
else
    echo "Error: $GRUB_CONFIG not found."
fi

echo "Catppuccin GRUB Theme configuration complete!"
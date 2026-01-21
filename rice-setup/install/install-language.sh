#!/bin/bash

# This script sets up the language and locale.

# Set the locale
echo "en_US.UTF-8 UTF-8" | sudo tee /etc/locale.gen
sudo locale-gen
echo "LANG=en_US.UTF-8" | sudo tee /etc/locale.conf

# Set the keyboard layout
hypr_config_dir="$HOME/.config/hypr"
input_conf="$hypr_config_dir/input.conf"
vconsole_conf="/etc/vconsole.conf"

if [ ! -d "$hypr_config_dir" ]; then
    mkdir -p "$hypr_config_dir"
fi

if [ ! -f "$input_conf" ]; then
    touch "$input_conf"
fi

if [ -f "$vconsole_conf" ]; then
    if grep -q '^XKBLAYOUT=' "$vconsole_conf"; then
      layout=$(grep '^XKBLAYOUT=' "$vconsole_conf" | cut -d= -f2 | tr -d '"')
      # Add kb_layout to input.conf if it's not already there
      if ! grep -q "kb_layout" "$input_conf"; then
        echo "  kb_layout = $layout" >> "$input_conf"
      fi
    fi

    if grep -q '^XKBVARIANT=' "$vconsole_conf"; then
      variant=$(grep '^XKBVARIANT=' "$vconsole_conf" | cut -d= -f2 | tr -d '"')
      # Add kb_variant to input.conf if it's not already there
      if ! grep -q "kb_variant" "$input_conf"; then
        echo "  kb_variant = $variant" >> "$input_conf"
      fi
    fi
fi

# Allow tzupdate and timedatectl to be run without a password
sudo tee /etc/sudoers.d/rice-setup-tzupdate >/dev/null <<EOF
%wheel ALL=(root) NOPASSWD: /usr/bin/tzupdate, /usr/bin/timedatectl
EOF
sudo chmod 0440 /etc/sudoers.d/rice-setup-tzupdate

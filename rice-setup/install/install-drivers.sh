#!/bin/bash

# This script installs drivers for your hardware.

# NVIDIA
if lspci | grep -i 'nvidia'; then
    echo "NVIDIA card detected, installing drivers..."
    # Check which kernel is installed and set appropriate headers package
    KERNEL_HEADERS="$(pacman -Qqs '^linux(-zen|-lts|-hardened)?$' | head -1)-headers"

    if lspci | grep -i 'nvidia' | grep -qE "RTX [2-9][0-9]|GTX 16"; then
        # Turing (16xx, 20xx), Ampere (30xx), Ada (40xx), and newer recommend the open-source kernel modules
        PACKAGES=(nvidia-open-dkms nvidia-utils lib32-nvidia-utils libva-nvidia-driver)
    elif lspci | grep -i 'nvidia' | grep -qE "GTX 9|GTX 10|Quadro P"; then
        # Pascal (10xx or Quadro Pxxx) and Maxwell (9xx) use legacy branch that can only be installed from AUR
        PACKAGES=(nvidia-580xx-dkms nvidia-580xx-utils lib32-nvidia-580xx-utils)
    fi
    
    if [ -n "${PACKAGES+x}" ]; then
        sudo pacman -S --noconfirm --needed "$KERNEL_HEADERS" "${PACKAGES[@]}"

        # Configure modprobe for early KMS
        sudo tee /etc/modprobe.d/nvidia.conf <<EOF >/dev/null
options nvidia_drm modeset=1
EOF

        # Configure mkinitcpio for early loading
        sudo tee /etc/mkinitcpio.conf.d/nvidia.conf <<EOF >/dev/null
MODULES+=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
EOF
    else
        echo "No compatible driver for your NVIDIA GPU. See: https://wiki.archlinux.org/title/NVIDIA"
    fi
fi

# Intel
if lspci | grep -iE 'vga|3d|display' | grep -i 'intel'; then
    echo "Intel GPU detected, installing drivers..."
    if lspci | grep -iE 'vga|3d|display' | grep -i 'intel' | grep -qiE "hd graphics|xe|iris"; then
        sudo pacman -S --needed --noconfirm intel-media-driver
    elif lspci | grep -iE 'vga|3d|display' | grep -i 'intel' | grep -qiE "gma"; then
        sudo pacman -S --needed --noconfirm libva-intel-driver
    fi
fi

# Broadcom
if lspci -nn | grep -q "14e4:43a0" || lspci -nn | grep -q "14e4:4331"; then
    echo "Broadcom wireless card detected, installing drivers..."
    sudo pacman -S --noconfirm --needed broadcom-wl-dkms dkms linux-headers
fi

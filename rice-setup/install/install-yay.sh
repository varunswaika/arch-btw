#!/bin/bash

# This script installs yay if it's not already installed.

if ! command -v yay &> /dev/null
then
    echo "yay could not be found, installing..."
    # Dependencies to build yay
    sudo pacman -S --needed --noconfirm git base-devel

    # Clone, build, and install yay
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
else
    echo "yay is already installed."
fi

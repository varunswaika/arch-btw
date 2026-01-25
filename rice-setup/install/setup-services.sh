#!/bin/bash

# This script enables necessary system services and configures user groups.

echo "Configuring system services and user groups..."

# --- Services ---

# Network (IWD)
if pacman -Qi iwd &> /dev/null; then
    echo "Enabling IWD service..."
    sudo systemctl enable --now iwd.service
fi

# Bluetooth
if pacman -Qi bluez &> /dev/null; then
    echo "Enabling Bluetooth service..."
    sudo systemctl enable --now bluetooth.service
fi

# Avahi (mDNS/DNS-SD)
if pacman -Qi avahi &> /dev/null; then
    echo "Enabling Avahi Daemon..."
    sudo systemctl enable --now avahi-daemon.service
fi

# Power Profiles Daemon
if pacman -Qi power-profiles-daemon &> /dev/null; then
    echo "Enabling Power Profiles Daemon..."
    sudo systemctl enable --now power-profiles-daemon.service
fi

# Docker
if pacman -Qi docker &> /dev/null; then
    echo "Enabling Docker service..."
    sudo systemctl enable --now docker.service
    
    # Add user to docker group
    echo "Adding user $USER to the docker group..."
    sudo usermod -aG docker "$USER"
    echo "Note: You will need to log out and back in for docker group changes to take effect."
fi

# --- Tool Specifics ---

# GitHub CLI
if command -v gh &> /dev/null; then
    echo "GitHub CLI is installed. Run 'gh auth login' manually to authenticate."
fi

# HyprPolkitAgent
# Usually starts automatically via Hyprland config (exec-once), 
# but good to ensure the package is there (handled by install-packages).

echo "Service configuration complete."

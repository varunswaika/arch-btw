#!/bin/bash

# Initialize swww if not already running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon --format argb &
    # Wait for the daemon to initialize properly
    for i in {1..50}; do
        if swww query >/dev/null 2>&1; then
            break
        fi
        sleep 0.1
    done
fi

# Set the wallpaper
swww img ~/.config/hypr/wallpapers/background.png --transition-type grow --transition-pos 0.9,0.9 --transition-step 90


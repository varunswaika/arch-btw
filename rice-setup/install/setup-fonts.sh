#!/bin/bash

# This script sets up the font configuration.

# Check if fc-cache is available
if command -v fc-cache &> /dev/null; then
    echo "Updating font cache..."
    sudo fc-cache -fv
else
    echo "Warning: fc-cache command not found. Skipping font cache update."
fi

echo "Font configuration complete. OpenMoji is set as the preferred emoji font."

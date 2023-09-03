#!/bin/bash

sudo pacman -S --needed - < pkglist.txt
echo "Pacman packages installed."

# Check if yay is already installed
if command -v yay &> /dev/null; then
    echo "yay is already installed."
    exit 0
fi

# Update package database
echo "Updating package database..."
sudo pacman -Sy

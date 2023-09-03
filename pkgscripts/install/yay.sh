#!/bin/bash

# Install git and base-devel if they are not installed
if ! command -v git &> /dev/null; then
    echo "Installing git..."
    sudo pacman -S --noconfirm git
fi

if ! pacman -Qg base-devel &> /dev/null; then
    echo "Installing base-devel..."
    sudo pacman -S --noconfirm base-devel
fi

# Clone yay repository and install yay
echo "Cloning yay repository..."
git clone https://aur.archlinux.org/yay.git

cd yay || { echo "Failed to enter yay directory."; exit 1; }

echo "Building and installing yay..."
makepkg -si --noconfirm

# Clean up
cd .. && rm -rf yay

echo "yay installation complete."

yay -S --needed - < aur_pkglist.txt
echo "AUR packages installed."


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

pip install -r py_pkglist.txt
echo "Python packages installed."

cat .txt | xargs -I {} cargo install {}
echo "Cargo packages installed."

cat rustup_toolchains.txt | xargs -I {} rustup install {}
echo "Rustup toolchains installed."

cat npm_packages.txt | xargs -I {} npm install -g {}
echo "NPM packages installed."

#!/bin/bash

# Check if TeX Live is already installed
if command -v pdflatex &> /dev/null; then
    echo "TeX Live is already installed."
    exit 0
fi

# Create a temporary directory for the TeX Live installer
temp_dir=$(mktemp -d)
cd "$temp_dir" || { echo "Failed to enter temporary directory."; exit 1; }

# Download the installer
echo "Downloading TeX Live installer..."
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz

# Extract the installer
echo "Extracting installer..."
tar -xzf install-tl-unx.tar.gz

# Navigate into the installer directory
cd install-tl-* || { echo "Failed to enter installer directory."; exit 1; }

# Run the installer
echo "Starting TeX Live installation..."
sudo ./install-tl

# Clean up
cd "$temp_dir" || { echo "Failed to return to temporary directory."; exit 1; }
rm -rf "$temp_dir"

echo "TeX Live installation complete."

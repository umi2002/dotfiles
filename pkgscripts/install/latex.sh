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
cd install-tl-*/ || { echo "Failed to enter installer directory."; exit 1; }

# Run the installer
echo "Starting TeX Live installation..."
sudo perl ./install-tl

# Clean up
cd "$temp_dir" || { echo "Failed to return to temporary directory."; exit 1; }
rm -rf "$temp_dir"

echo "TeX Live installation complete."
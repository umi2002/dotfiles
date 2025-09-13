#!/bin/bash
# ~/.config/aconfmgr/20-desktop-environment.sh

# Desktop Apps
AddPackage dunst # Customizable and lightweight notification-daemon
AddPackage flameshot # Powerful yet simple to use screenshot software
AddPackage hyprland # a highly customizable dynamic tiling Wayland compositor
AddPackage hyprpaper # a blazing fast wayland wallpaper utility with IPC controls
AddPackage rofi # A window switcher, application launcher and dmenu replacement
AddPackage spotify-launcher # Client for spotify's apt repository in Rust for Arch Linux
AddPackage discord # All-in-one voice and text chat for gamers
AddPackage --foreign eww # Standalone widget system made in Rust
AddPackage --foreign brave-bin # Web browser that blocks ads and trackers by default (binary release)

# Printer
AddPackage cups # OpenPrinting CUPS - daemon package
AddPackage cups-pdf # PDF printer for cups

# Fonts
AddPackage otf-firamono-nerd # Patched font Fira (Fura) Mono from nerd fonts library
AddPackage ttf-jetbrains-mono-nerd # Patched font JetBrains Mono from nerd fonts library

# Xorg
AddPackage xorg-xauth # X.Org authorization settings program
AddPackage xorg-xhost # Server access control program for X

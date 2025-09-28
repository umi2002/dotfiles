#!/bin/bash
# ~/.config/aconfmgr/20-desktop-environment.sh

# Desktop Apps
AddPackage dunst # Customizable and lightweight notification-daemon
AddPackage flameshot # Powerful yet simple to use screenshot software
AddPackage hyprland # a highly customizable dynamic tiling Wayland compositor
AddPackage hyprpaper # a blazing fast wayland wallpaper utility with IPC controls
AddPackage rofi # A window switcher, application launcher and dmenu replacement
AddPackage --foreign spotify # A proprietary music streaming service
AddPackage discord # All-in-one voice and text chat for gamers
AddPackage --foreign brave-bin # Web browser that blocks ads and trackers by default (binary release)
AddPackage --foreign quickshell # Flexible toolkit for making desktop shells with QtQuick
AddPackage vlc # Free and open source cross-platform multimedia player and framework
AddPackage --foreign pwvucontrol # Pipewire volume control for GNOME

# Printer
AddPackage cups # OpenPrinting CUPS - daemon package
AddPackage cups-pdf # PDF printer for cups
AddPackage --foreign librewolf-bin # Community-maintained fork of Firefox, focused on privacy, security and freedom.

# Fonts
AddPackage otf-firamono-nerd # Patched font Fira (Fura) Mono from nerd fonts library
AddPackage ttf-jetbrains-mono-nerd # Patched font JetBrains Mono from nerd fonts library
AddPackage noto-fonts # Google Noto TTF fonts
AddPackage ttf-iosevka-nerd # Patched font Iosevka from nerd fonts library
AddPackage --foreign ttf-mac-fonts # Mac fonts including Lucida Grande, Apple Garamond and other fonts from Apple
AddPackage --foreign ttf-ms-fonts # Core TTF Fonts from Microsoft
AddPackage ttf-cascadia-code-nerd # Patched font Cascadia Code (Caskaydia) from nerd fonts library

# Xorg
AddPackage xorg-xauth # X.Org authorization settings program
AddPackage xorg-xhost # Server access control program for X

#!/bin/bash
# ~/.config/aconfmgr/20-desktop-environment.sh

# Desktop Apps
AddPackage dunst # Customizable and lightweight notification-daemon
AddPackage flameshot # Powerful yet simple to use screenshot software
AddPackage hyprland # a highly customizable dynamic tiling Wayland compositor
AddPackage hyprpaper # a blazing fast wayland wallpaper utility with IPC controls
AddPackage rofi # A window switcher, application launcher and dmenu replacement
AddPackage --foreign spotify # A proprietary music streaming service
AddPackage vlc # Free and open source cross-platform multimedia player and framework
AddPackage vlc-plugins-all # Free and open source cross-platform multimedia player and framework - all plugins
AddPackage --foreign pwvucontrol # Pipewire volume control for GNOME
AddPackage --foreign zen-browser-bin # Performance oriented Firefox-based web browser
AddPackage obs-studio # Free, open source software for live streaming and recording
AddPackage qbittorrent # An advanced BitTorrent client programmed in C++, based on Qt toolkit and libtorrent-rasterbar
AddPackage quickshell # Flexible toolkit for making desktop shells with QtQuick
AddPackage steam # Valve's digital software delivery system
AddPackage --foreign vesktop # A standalone Electron-based Discord app with Vencord & improved Linux support

# Printer
AddPackage cups # OpenPrinting CUPS - daemon package
AddPackage cups-pdf # PDF printer for cups

# Fonts
AddPackage otf-firamono-nerd # Patched font Fira (Fura) Mono from nerd fonts library
AddPackage ttf-jetbrains-mono-nerd # Patched font JetBrains Mono from nerd fonts library
AddPackage noto-fonts # Google Noto TTF fonts
AddPackage ttf-iosevka-nerd # Patched font Iosevka from nerd fonts library
AddPackage --foreign ttf-mac-fonts # Mac fonts including Lucida Grande, Apple Garamond and other fonts from Apple
AddPackage --foreign ttf-ms-fonts # Core TTF Fonts from Microsoft
AddPackage ttf-cascadia-code-nerd # Patched font Cascadia Code (Caskaydia) from nerd fonts library
AddPackage cantarell-fonts # Humanist sans serif font
AddPackage noto-fonts-cjk # Google Noto CJK fonts

# Xorg
AddPackage xorg-xauth # X.Org authorization settings program
AddPackage xorg-xhost # Server access control program for X

#!/bin/bash
# ~/.config/aconfmgr/20-desktop-environment.sh

# Desktop Apps
AddPackage uwsm # A standalone Wayland session manager
AddPackage hyprland # a highly customizable dynamic tiling Wayland compositor
AddPackage hyprpaper # a blazing fast wayland wallpaper utility with IPC controls
AddPackage hyprlock # hyprland’s GPU-accelerated screen locking utility
AddPackage hypridle # hyprland’s idle daemon
AddPackage --foreign runapp # Application runner for Linux desktop environments that integrate with systemd
AddPackage --foreign spotify # A proprietary music streaming service
AddPackage --foreign spicetify-cli # Command-line tool to customize Spotify client
AddPackage --foreign spicetify-marketplace-bin # Spicetify app that integrates a marketplace for extensions, themes and snippets
AddPackage vlc # Free and open source cross-platform multimedia player and framework
AddPackage vlc-plugins-all # Free and open source cross-platform multimedia player and framework - all plugins
AddPackage --foreign pwvucontrol # Pipewire volume control for GNOME
AddPackage --foreign brave-bin # Web browser that blocks ads and trackers by default (binary release)
AddPackage obs-studio # Free, open source software for live streaming and recording
AddPackage qbittorrent # An advanced BitTorrent client programmed in C++, based on Qt toolkit and libtorrent-rasterbar
AddPackage --foreign quickshell-git # Flexible toolkit for making desktop shells with QtQuick
AddPackage --foreign caelestia-shell # The desktop shell for the Caelestia dotfiles
AddPackage --foreign quickshell-greetd # Use Quickshell lockscreen as greetd greeter
AddPackage steam # Valve's digital software delivery system
AddPackage --foreign vesktop # A standalone Electron-based Discord app with Vencord & improved Linux support
AddPackage libreoffice-fresh # LibreOffice branch which contains new features and program enhancements
AddPackage --foreign betterbird-bin # EN-US // Betterbird is a fine-tuned version of Mozilla Thunderbird, Thunderbird on steroids, if you will.
AddPackage yazi # Blazing fast terminal file manager written in Rust, based on async I/O
AddPackage emacs # The extensible, customizable, self-documenting real-time display editor
AddPackage bitwarden # A secure and free password manager for all of your devices

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
AddPackage noto-fonts-emoji # Google Noto Color Emoji font
AddPackage ttf-linux-libertine # Serif (Libertine) and Sans Serif (Biolinum) OpenType fonts with large Unicode coverage

# Cursors
AddPackage --foreign catppuccin-cursors-mocha # Soothing pastel mouse cursors - Mocha

# Xorg
AddPackage xorg-xauth # X.Org authorization settings program
AddPackage xorg-xhost # Server access control program for X

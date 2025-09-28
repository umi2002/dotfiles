#!/bin/bash
# ~/.config/aconfmgr/10-base.sh

# Base System
AddPackage base # Minimal package set to define a basic Arch Linux installation
AddPackage base-devel # Basic tools to build Arch Linux packages
AddPackage linux # The Linux kernel and modules
AddPackage linux-firmware # Firmware files for Linux - Default set
AddPackage linux-headers # Headers and scripts for building modules for the Linux kernel
AddPackage dkms # Dynamic Kernel Modules System

# Boot
AddPackage grub # GNU GRand Unified Bootloader (2)
AddPackage efibootmgr # Linux user-space application to modify the EFI Boot Manager

# Hardware Support
AddPackage amd-ucode # Microcode update image for AMD CPUs
AddPackage udisks2 # Daemon, tools and libraries to access and manipulate disks, storage devices and technologies

#Networking
AddPackage networkmanager # Network connection manager and user applications
AddPackage openssh # SSH protocol implementation for remote login, command execution and file transfer
AddPackage nss-mdns # glibc plugin providing host name resolution via mDNS
AddPackage bluez # Daemons for the bluetooth protocol stack
AddPackage bluez-utils # Development and debugging utilities for the bluetooth protocol stack

# Essential Utilities
AddPackage git # the fast distributed version control system
AddPackage man-db # A utility for reading man pages
AddPackage man-pages # Linux man pages
AddPackage reflector # A Python 3 module and script to retrieve and filter the latest Pacman mirror list.
AddPackage kitty # A modern, hackable, featureful, OpenGL-based terminal emulator
AddPackage alsa-utils # Advanced Linux Sound Architecture - Utilities
AddPackage vi # The original ex/vi text editor
AddPackage brightnessctl # Lightweight brightness control tool
AddPackage pipewire # Low-latency audio/video router and processor
AddPackage pipewire-pulse # Low-latency audio/video router and processor - PulseAudio replacement
AddPackage wget # Network utility to retrieve files from the web
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux
AddPackage --foreign yay # Yet another yogurt. Pacman wrapper and AUR helper written in go.
AddPackage --foreign yay-debug # Detached debugging symbols for yay
AddPackage udiskie # Removable disk automounter using udisks

# Essential Laptop Utilities
AddPackage acpid # A daemon for delivering ACPI power management events with netlink support
AddPackage tlp # Linux Advanced Power Management

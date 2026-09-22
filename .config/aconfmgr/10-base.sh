#!/bin/bash
# ~/.config/aconfmgr/10-base.sh

# Base System
AddPackage base                # Minimal package set to define a basic Arch Linux installation
AddPackage base-devel          # Basic tools to build Arch Linux packages
AddPackage linux               # The Linux kernel and modules
AddPackage linux-firmware      # Firmware files for Linux - Default set
AddPackage linux-firmware-qcom # Firmware files for Linux - Firmware for Qualcomm SoCs
AddPackage linux-headers       # Headers and scripts for building modules for the Linux kernel
AddPackage dkms                # Dynamic Kernel Modules System
AddPackage linux-lts           # The LTS Linux kernel and modules
AddPackage linux-lts-headers   # Headers and scripts for building modules for the LTS Linux kernel

# Boot
AddPackage grub       # GNU GRand Unified Bootloader (2)
AddPackage efibootmgr # Linux user-space application to modify the EFI Boot Manager

# Hardware Support
AddPackage amd-ucode # Microcode update image for AMD CPUs
AddPackage udisks2   # Daemon, tools and libraries to access and manipulate disks, storage devices and technologies
AddPackage keyd      # A key remapping daemon for linux

#Networking
AddPackage networkmanager # Network connection manager and user applications
AddPackage iwd            # Internet Wireless Daemon
AddPackage iw             # nl80211 based CLI configuration utility for wireless devices
AddPackage wireless-regdb # Central Regulatory Domain Database
AddPackage openssh        # SSH protocol implementation for remote login, command execution and file transfer
AddPackage nss-mdns       # glibc plugin providing host name resolution via mDNS
AddPackage bluez          # Daemons for the bluetooth protocol stack
AddPackage bluez-utils    # Development and debugging utilities for the bluetooth protocol stack
AddPackage bind           # A complete, highly portable implementation of the DNS protocol
AddPackage openbsd-netcat # TCP/IP swiss army knife. OpenBSD variant.

# Essential Utilities
AddPackage git                    # the fast distributed version control system
AddPackage man-db                 # A utility for reading man pages
AddPackage man-pages              # Linux man pages
AddPackage pacman-contrib         # Contributed scripts and tools for pacman systems
AddPackage reflector              # A Python 3 module and script to retrieve and filter the latest Pacman mirror list.
AddPackage informant              # An Arch Linux News reader and pacman hook
AddPackage alsa-utils             # Advanced Linux Sound Architecture - Utilities
AddPackage ex-vi-compat           # The ex and vi commands based on vim's compatibility modes
AddPackage pipewire               # Low-latency audio/video router and processor
AddPackage pipewire-pulse         # Low-latency audio/video router and processor - PulseAudio replacement
AddPackage pipewire-alsa          # Low-latency audio/video router and processor - ALSA configuration
AddPackage pipewire-libcamera     # Low-latency audio/video router and processor - Libcamera support
AddPackage speech-dispatcher      # High-level device independent layer for speech synthesis interface
AddPackage rtkit                  # Realtime Policy and Watchdog Daemon
AddPackage wget                   # Network utility to retrieve files from the web
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux
AddPackage --foreign yay          # Yet another yogurt. Pacman wrapper and AUR helper written in go.
AddPackage udiskie                # Removable disk automounter using udisks
AddPackage ufw                    # Uncomplicated and easy to use CLI tool for managing a netfilter firewall
AddPackage inetutils              # A collection of common network programs
AddPackage gnome-keyring          # Stores passwords and encryption keys

# Essential Laptop Utilities
AddPackage acpid                         # A daemon for delivering ACPI power management events with netlink support
AddPackage tlp                           # Linux Advanced Power Management
AddPackage tlp-pd                        # Linux Advanced Power Management - Power Profiles Daemon
AddPackage --foreign powertop-git        # A tool to diagnose issues with power consumption and power management, git version
AddPackage --foreign powertop-to-tmpfile # Apply PowerTOP recommendations via a tmpfiles.d configuration file

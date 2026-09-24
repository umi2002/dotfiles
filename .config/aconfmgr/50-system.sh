# Locale & Console
CopyFile /etc/locale.conf
CopyFile /etc/locale.gen
CreateLink /etc/localtime /usr/share/zoneinfo/America/Montreal
CopyFile /etc/vconsole.conf

# Filesystem
SetFileProperty / mode 555
CreateDir /lost+found 700

# Boot
CopyFile /etc/default/grub

# Pacman
CopyFile /etc/pacman.conf
CopyFile /etc/xdg/reflector/reflector.conf
CopyFile /etc/systemd/system/reflector.timer
CreateLink /etc/systemd/system/timers.target.wants/reflector.timer /usr/lib/systemd/system/reflector.timer
CreateLink /etc/systemd/system/timers.target.wants/paccache.timer /usr/lib/systemd/system/paccache.timer

# Sudo
CopyFile /etc/sudoers

# PAM
CopyFile /etc/pam.d/greetd
CopyFile /etc/pam.d/passwd

# Input
CopyFile /etc/keyd/default.conf
CreateLink /etc/systemd/system/multi-user.target.wants/keyd.service /usr/lib/systemd/system/keyd.service

# Networking
CopyFile /etc/nsswitch.conf
CopyFile /etc/NetworkManager/conf.d/wifi_backend.conf
CopyFile /etc/iwd/main.conf
CreateLink /etc/systemd/system/multi-user.target.wants/NetworkManager.service /usr/lib/systemd/system/NetworkManager.service
CreateLink /etc/systemd/system/multi-user.target.wants/avahi-daemon.service /usr/lib/systemd/system/avahi-daemon.service
CreateLink /etc/systemd/system/sockets.target.wants/avahi-daemon.socket /usr/lib/systemd/system/avahi-daemon.socket

# Firewall
CopyFile /etc/default/ufw
CopyFile /etc/ufw/after.rules
CopyFile /etc/ufw/after6.rules
CopyFile /etc/ufw/before.rules
CopyFile /etc/ufw/before6.rules
CopyFile /etc/ufw/ufw.conf
CopyFile /etc/ufw/user.rules
CopyFile /etc/ufw/user6.rules
CreateLink /etc/systemd/system/multi-user.target.wants/ufw.service /usr/lib/systemd/system/ufw.service

# Bluetooth
CopyFile /etc/bluetooth/main.conf
SetFileProperty /etc/bluetooth mode 755
CreateLink /etc/systemd/system/bluetooth.target.wants/bluetooth.service /usr/lib/systemd/system/bluetooth.service

# Power
CopyFile /etc/tlp.conf
CopyFile /etc/tmpfiles.d/powertop.conf
CreateLink /etc/systemd/system/graphical.target.wants/tlp-pd.service /usr/lib/systemd/system/tlp-pd.service
CreateLink /etc/systemd/system/multi-user.target.wants/tlp.service /usr/lib/systemd/system/tlp.service
CreateLink /etc/systemd/system/multi-user.target.wants/acpid.service /usr/lib/systemd/system/acpid.service
CreateLink /etc/systemd/system/systemd-rfkill.service /dev/null
CreateLink /etc/systemd/system/systemd-rfkill.socket /dev/null

# Devices
CopyFile /etc/udev/rules.d/01-ttyusb.rules
CopyFile /etc/udev/rules.d/99-brightness.rules
CopyFile /usr/local/bin/brightness.sh 755

# greetd
CopyFile /etc/greetd/config.toml
CopyFile /etc/greetd/hyprland.lua
CopyFile /etc/greetd/login_wallpaper.svg
CreateLink /etc/systemd/system/display-manager.service /usr/lib/systemd/system/greetd.service

# Printing
CreateLink /etc/systemd/system/multi-user.target.wants/cups.path /usr/lib/systemd/system/cups.path
CreateLink /etc/systemd/system/multi-user.target.wants/cups.service /usr/lib/systemd/system/cups.service
CreateLink /etc/systemd/system/printer.target.wants/cups.service /usr/lib/systemd/system/cups.service
CreateLink /etc/systemd/system/sockets.target.wants/cups.socket /usr/lib/systemd/system/cups.socket

# Development Services
CreateLink /etc/systemd/system/sockets.target.wants/docker.socket /usr/lib/systemd/system/docker.socket
CreateLink /etc/systemd/system/multi-user.target.wants/postgresql.service /usr/lib/systemd/system/postgresql.service

# libvirt
CopyFile /etc/libvirt/qemu/RDPWindows.xml 600
CopyFile /etc/libvirt/qemu/networks/default.xml
CreateLink /etc/libvirt/qemu/networks/autostart/default.xml /etc/libvirt/qemu/networks/default.xml
CreateLink /etc/systemd/system/multi-user.target.wants/libvirtd.service /usr/lib/systemd/system/libvirtd.service
CreateLink /etc/systemd/system/sockets.target.wants/libvirtd-admin.socket /usr/lib/systemd/system/libvirtd-admin.socket
CreateLink /etc/systemd/system/sockets.target.wants/libvirtd-ro.socket /usr/lib/systemd/system/libvirtd-ro.socket
CreateLink /etc/systemd/system/sockets.target.wants/libvirtd.socket /usr/lib/systemd/system/libvirtd.socket
CreateLink /etc/systemd/system/sockets.target.wants/virtlockd-admin.socket /usr/lib/systemd/system/virtlockd-admin.socket
CreateLink /etc/systemd/system/sockets.target.wants/virtlockd.socket /usr/lib/systemd/system/virtlockd.socket
CreateLink /etc/systemd/system/sockets.target.wants/virtlogd-admin.socket /usr/lib/systemd/system/virtlogd-admin.socket
CreateLink /etc/systemd/system/sockets.target.wants/virtlogd.socket /usr/lib/systemd/system/virtlogd.socket

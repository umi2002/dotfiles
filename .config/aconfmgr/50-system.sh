CopyFile /etc/locale.conf
CopyFile /etc/locale.gen
CreateLink /etc/localtime /usr/share/zoneinfo/America/Montreal
CopyFile /etc/xdg/reflector/reflector.conf
CopyFile /etc/pacman.conf
CopyFile /etc/sudoers
CopyFile /etc/vconsole.conf
CreateDir /lost+found 700
CopyFile /etc/keyd/default.conf
CopyFile /etc/nsswitch.conf
CopyFile /etc/NetworkManager/dispatcher.d/90-open_captive_portal 755
CopyFile /etc/default/ufw
CopyFile /etc/greetd/config.toml
CopyFile /etc/greetd/hyprland.conf
CopyFile /etc/greetd/login_wallpaper.svg
CreateDir /var/lib/greeter 755 greeter greeter
CopyFile /etc/udev/rules.d/01-ttyusb.rules
CopyFile /etc/udev/rules.d/99-brightness.rules
CopyFile /etc/ufw/after.rules
CopyFile /etc/ufw/after6.rules
CopyFile /etc/ufw/before.rules
CopyFile /etc/ufw/before6.rules
CopyFile /etc/ufw/ufw.conf
CopyFile /etc/ufw/user.rules
CopyFile /etc/ufw/user6.rules
CopyFile /etc/default/grub
CopyFile /etc/tlp.conf
CopyFile /etc/NetworkManager/conf.d/wifi_backend.conf
CopyFile /etc/iwd/main.conf
CopyFile /etc/systemd/system/bluetooth-off.service
CopyFile /etc/tmpfiles.d/powertop.conf
CopyFile /etc/systemd/system/reflector.timer
CopyFile /usr/local/bin/brightness.sh 755

CreateLink /etc/systemd/system/bluetooth.target.wants/bluetooth.service /usr/lib/systemd/system/bluetooth.service
CreateLink /etc/systemd/system/display-manager.service /usr/lib/systemd/system/greetd.service
CreateLink /etc/systemd/system/graphical.target.wants/tlp-pd.service /usr/lib/systemd/system/tlp-pd.service
CreateLink /etc/systemd/system/multi-user.target.wants/acpid.service /usr/lib/systemd/system/acpid.service
CreateLink /etc/systemd/system/multi-user.target.wants/avahi-daemon.service /usr/lib/systemd/system/avahi-daemon.service
CreateLink /etc/systemd/system/multi-user.target.wants/bluetooth-off.service /etc/systemd/system/bluetooth-off.service
CreateLink /etc/systemd/system/multi-user.target.wants/cups.path /usr/lib/systemd/system/cups.path
CreateLink /etc/systemd/system/multi-user.target.wants/cups.service /usr/lib/systemd/system/cups.service
CreateLink /etc/systemd/system/multi-user.target.wants/keyd.service /usr/lib/systemd/system/keyd.service
CreateLink /etc/systemd/system/multi-user.target.wants/NetworkManager.service /usr/lib/systemd/system/NetworkManager.service
CreateLink /etc/systemd/system/multi-user.target.wants/postgresql.service /usr/lib/systemd/system/postgresql.service
CreateLink /etc/systemd/system/multi-user.target.wants/seatd.service /usr/lib/systemd/system/seatd.service
CreateLink /etc/systemd/system/multi-user.target.wants/tlp.service /usr/lib/systemd/system/tlp.service
CreateLink /etc/systemd/system/multi-user.target.wants/ufw.service /usr/lib/systemd/system/ufw.service
CreateLink /etc/systemd/system/printer.target.wants/cups.service /usr/lib/systemd/system/cups.service
CreateLink /etc/systemd/system/sockets.target.wants/avahi-daemon.socket /usr/lib/systemd/system/avahi-daemon.socket
CreateLink /etc/systemd/system/sockets.target.wants/cups.socket /usr/lib/systemd/system/cups.socket
CreateLink /etc/systemd/system/sockets.target.wants/docker.socket /usr/lib/systemd/system/docker.socket
CreateLink /etc/systemd/system/timers.target.wants/reflector.timer /usr/lib/systemd/system/reflector.timer
CreateLink /etc/systemd/system/systemd-rfkill.service /dev/null
CreateLink /etc/systemd/system/systemd-rfkill.socket /dev/null

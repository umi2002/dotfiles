CopyFile /etc/locale.conf
CopyFile /etc/locale.gen
CreateLink /etc/localtime /usr/share/zoneinfo/America/Montreal
CopyFile /etc/xdg/reflector/reflector.conf
CopyFile /etc/pacman.d/mirrorlist
CopyFile /etc/pacman.d/mirrorlist.pacnew
CopyFile /etc/pacman.conf
CopyFile /etc/sudoers
CopyFile /etc/vconsole.conf
CreateDir /lost+found 700
CopyFile /etc/keyd/default.conf '' umi umi
CopyFile /etc/nsswitch.conf
CopyFile /etc/NetworkManager/dispatcher.d/90-open_captive_portal 755 umi umi
CopyFile /etc/default/ufw
CopyFile /etc/greetd/config.toml
CopyFile /etc/greetd/hyprland.conf
CopyFile /etc/greetd/login_wallpaper.png
CopyFile /etc/greetd/login_wallpaper.webp
CopyFile /etc/greetd/regreet.css
CopyFile /etc/greetd/regreet.toml
CopyFile /etc/udev/rules.d/01-ttyusb.rules
CopyFile /etc/ufw/after.rules
CopyFile /etc/ufw/after6.rules
CopyFile /etc/ufw/before.rules
CopyFile /etc/ufw/before6.rules
CopyFile /etc/ufw/ufw.conf
CopyFile /etc/ufw/user.rules
CopyFile /etc/ufw/user6.rules
CreateDir /etc/audit/plugins.d 750

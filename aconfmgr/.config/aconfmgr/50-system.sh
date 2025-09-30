CopyFile /etc/locale.conf
CopyFile /etc/locale.gen
CreateLink /etc/localtime /usr/share/zoneinfo/America/Montreal
CopyFile /etc/xdg/reflector/reflector.conf
CopyFile /etc/pacman.d/mirrorlist
CopyFile /etc/sudoers
CopyFile /etc/vconsole.conf
CreateDir /lost+found 700
CopyFile /etc/keyd/default.conf '' umi umi
CopyFile /etc/nsswitch.conf
CopyFile /etc/NetworkManager/dispatcher.d/90-open_captive_portal 755 umi umi

#!/bin/bash
sudo pacman -S --needed base-devel git yadm fzf
echo "Installation of initial package dependencies successful."

git clone https://aur.archlinux.org/yay.git /tmp/yay
(cd /tmp/yay && makepkg -sirc)
rm -rf /tmp/yay
echo "Installation of yay (AUR helper) successful."

yay -S aconfmgr-git
echo "Installation of aconfmgr successful."

yadm init
CLASS=$(echo -e "Desktop\nLaptop" | fzf --prompt="Select class: ")
yadm config local.class "$CLASS"
yadm remote add origin <repo-url>
yadm pull origin main
echo "Initialized and pulled yadm repo successfully."

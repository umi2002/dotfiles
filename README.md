# DOTFILES

The rest of the commit history can be found in the [archived dotfiles repo](https://github.com/umi2002/dotfiles-old).

## Before installing

These scripts assume you are using [Arch Linux](https://wiki.archlinux.org/title/Main_page) as your operating system. All packages are installed using [pacman](https://pacman.archlinux.page/) or installed from the [AUR](https://aur.archlinux.org/) using [yay](https://github.com/Jguer/yay). However, feel free to clone the repository and use the standalone configurations as you see fit!

Assuming you are installing from a fresh Arch installation, here is what you need:

- A network connection

- [cURL](https://curl.se/):

```
sudo pacman -Sy -needed curl
```

That's it!

## Bootstrapping

You can bootstrap the dotfiles on a new machine by curling the [`bootstrap_dotfiles.sh`](https://github.com/umi2002/dotfiles/blob/main/bootstrap_dotfiles.sh) sript:

```
bash <(curl -sL https://raw.githubusercontent.com/umi2002/dotfiles/main/bootstrap_dotfiles.sh)
```

## How the script works

1. Basic dependencies

A few basic dependencies are first needed to correctly install these dotfiles, notably:

- [base-devel](https://archlinux.org/packages/core/any/base-devel/) (you most likely already have this installed but just in case)
- [git](https://git-scm.com/)
- [yadm](https://yadm.io/)
- [fzf](https://junegunn.github.io/fzf/)

```
sudo pacman -S --needed base-devel git yadm fzf
```

2. AUR helper

There is technically another basic dependency that is needed but it is only available through the AUR. So, you'll have to install an AUR helper. I chose yay.

```
git clone https://aur.archlinux.org/yay.git /tmp/yay
(cd /tmp/yay && makepkg -sirc)
rm -rf /tmp/yay
```

3. Installing aconfmgr

The final basic dependency needed is [aconfmgr](https://github.com/CyberShadow/aconfmgr), which is only available through the AUR. This package pulls a lot of weight for managing packages and system wide configuration across different machines.It has a bit of a learning curve and takes some time to set up, but it is very much worth it. I cannot stress how good this software is for Arch users.

```
yay -S aconfmgr-git
```

4. Setting up yadm

You are now ready to pull the repo and install the configuration files. I use yadm to manage them cleanly in my home directory.

You will also be prompted to choose between two classes; Laptop or Desktop. This is a feature of yadm that allows me to have slightly different configurations for a laptop environment vs a desktop environment. The main differences between the two is how aesthetics vs battery life is balanced. For the most part, you can use either configuration regardless of what kind of device you are rocking.

```
yadm init
CLASS=$(echo -e "Desktop\nLaptop" | fzf --prompt="Select class: ")
yadm config local.class "$CLASS"
yadm remote add origin https://github.com/umi2002/dotfiles.git
yadm pull origin main
```

5. Finishing up the rest of the installation process

At this point, the initial bootstrap script is complete and you should be prompted by yadm to run its own bootstrap script. I highly recommend you to answer yes, as it will continue installing the rest of the non basic packages that are needed for the dotfiles to work. Things might get messy if you don't, particularly concerning the [greeter](https://git.sr.ht/~kennylevinsen/greetd). If you ever get stuck on the login screen, switch to another tty to debug it. More details on the script can be found in [yadm's config directory](https://github.com/umi2002/dotfiles/tree/main/.config/yadm).

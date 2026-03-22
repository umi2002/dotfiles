# YADM CONFIG

After pulling the repo with yadm, you can now run the [yadm bootstrap script](https://github.com/umi2002/dotfiles/blob/main/.config/yadm/bootstrap). There are typically 3 ways you can run it:

- After pulling the repo, either through my initial bootstrap script or through `yadm pull`, you will be prompted to run the script. Answer yes to do so.
- Executing the following command: `yadm bootstrap`.
- Executing the script directly: `./bootstrap`

## How the script works

1. Setting up the environment with aconfmgr

Simply put, all this step does is run `aconfmgr apply`. Under the hood, there are tons of things happening. It will download the rest of the packages you need, copy relevant system wide configurations to your system and create relevant symlinks. This will take some time, particularly when installing packages.

```
aconfmgr apply
```

2. Setting up the login screen

This step is very important if you don't want to get stuck in the login screen. It uses my custom [quickshell config](https://github.com/umi2002/dotfiles/tree/main/.config/quickshell) along with greetd for a clean login UI.

For this to work, you must first symlink the quickshell config to greetd's config directory.

```
USER_HOME="$HOME"
quickshell_path="$USER_HOME/.config/quickshell"
sudo ln -sf "$quickshell_path" /etc/greetd
```

Then, there are a few things that are needed for the greeter to work correctly:

- It needs to be able to traverse the actual path to the quickshell config if it wants to read the symlinked config.
- The greeter user needs a home directory.

```
sudo mkdir -p /var/lib/greeter
sudo chown greeter:greeter /var/lib/greeter
sudo usermod -d /var/lib/greeter greeter
```

3. Setting up secrets with Bitwarden

Some configs require secrets that I unfortunately cannot leak. I use bitwarden to store those secrets and this step is meant to pull those files from bitwarden's vault and place them in the correct directories. As of this moment, here are the files that need to pulled from the vault:

- `~/.config/quickshell/Secrets.qml`

```
if bw login --check &>/dev/null; then
  export BW_SESSION=$(bw unlock --raw)
else
  export BW_SESSION=$(bw login --raw)
fi
bw get notes "Secrets.qml" --session $BW_SESSION > "$HOME/.config/quickshell/Secrets.qml"
bw lock
```

4. Setting up gtk

This step is truly unimportant. It is mostly here to set up default dark mode for apps that use gtk as well as some default gtk icons. I've decided to configure it here but you can easily do so elsewhere or with your own configuration file.

```
gsettings set org.gnome.desktop.interface gtk-theme 'Fluent-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

5. Enjoy!

If you have made it this far without any problems, you may enjoy my hand crafted configurations. Happy ricing!

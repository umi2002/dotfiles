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
quickshell_path="$HOME/.config/quickshell"
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

3. Unlocking Bitwarden vault

Some configs require secrets that I unfortunately cannot leak. I use bitwarden to store those secrets and this step is meant to pull those files from bitwarden's vault and place them in the correct directories.

```
if bw login --check &>/dev/null; then
  export BW_SESSION=$(bw unlock --raw)
else
  export BW_SESSION=$(bw login --raw)
fi
```

4. Setting up quickshell secrets with Bitwarden

Quickshell has some secrets needed for the config which will be generated at `~/.config/quickshell/Secrets.qml`.

```
bw get notes "Secrets.qml" --session $BW_SESSION > "$HOME/.config/quickshell/Secrets.qml"
```

5. Setting up github secrets with Bitwarden

To allow myself to edit my dotfiles, I need to generate an ssh key and store it. It gives me the option to either add a new key or replace an existing one if I am regenerating a key for the same machine.

```
GITHUB_PAT=$(bw get notes "Github Personal Access Token" --session $BW_SESSION | tr -d '[:space:]')
KEY_PATH="$HOME/.ssh/id_ed25519_github"
KEY_COMMENT="$(whoami)@$(hostname)"
mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
rm -f "$KEY_PATH" "$KEY_PATH.pub"
ssh-keygen -t ed25519 -f "$KEY_PATH" -C "$KEY_COMMENT" -N ""

KEYS_LIST=$(GH_TOKEN="$GITHUB_PAT" gh ssh-key list)
SELECTED=$(printf '+ Add as new key\n%s' \
  "$(echo "$KEYS_LIST" | awk -F'\t' '{print "~ Replace: " $1}')" | fzf \
  --prompt="GitHub SSH key action: " \
  --layout=reverse --height=40% --border)

if [[ "$SELECTED" == "+ Add as new key" ]]; then
  GH_TOKEN="$GITHUB_PAT" gh ssh-key add "$KEY_PATH.pub" --title "$KEY_COMMENT"
  echo "GitHub SSH key added."
elif [[ "$SELECTED" == "~ Replace: "* ]]; then
  KEY_TITLE="${SELECTED#\~ Replace: }"
  KEY_ID=$(echo "$KEYS_LIST" | awk -F'\t' -v t="$KEY_TITLE" '$1 == t {print $2}')
  GH_TOKEN="$GITHUB_PAT" gh ssh-key delete "$KEY_ID" --yes
  GH_TOKEN="$GITHUB_PAT" gh ssh-key add "$KEY_PATH.pub" --title "$KEY_TITLE"
  echo "GitHub SSH key replaced."
fi
echo "GitHub SSH key setup successful."
```

After all secrets have been set up, lock the vault.

```
bw lock
```

6. Setting up gtk

This step is truly unimportant. It is mostly here to set up default dark mode for apps that use gtk as well as some default gtk icons. I've decided to configure it here but you can easily do so elsewhere or with your own configuration file.

```
gsettings set org.gnome.desktop.interface gtk-theme 'Fluent-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

7. Enjoy!

If you have made it this far without any problems, you may enjoy my hand crafted configurations. Happy ricing!

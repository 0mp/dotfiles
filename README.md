# dotfiles

## FreeBSD

```sh
# dwm
mkdir -p ${HOME}/h
git clone http://github.com/0mp/dwm ${HOME}/h/dwm
make -C ${HOME}/h/dwm clean dwm install

# makaron
mkdir -p ${HOME}
git clone --recursive https://github.com/0mp/makaron ${HOME}/h/makaron
make -C ${HOME}/h/makaron install

# goat
mkdir -p ${HOME}/h
git clone http://github.com/0mp/goat ${HOME}/h/goat
make -C ${HOME}/h/goat clean install
```

### mDNS

```sh
pkg install avahi-app nss_mdns
sysrc avahi_daemon_enable="YES"
sysrc dbus_enable="YES"
if ! grep -q "hosts.*:.*mdns" /etc/nsswitch.conf; then
    tmp="$(mktemp)" && \
    sed '/hosts/s/$/ mdns/' /etc/nsswitch.conf > "$tmp" && \
    cat "$tmp" > /etc/nsswitch.conf
    rm "$tmp"
fi
```

Finally, add `mdns` to the `hosts` line in `/etc/nsswitch.conf`.

### Give less memory to ARC

```
sysctl vfs.zfs.arc_max=$(expr -- $(sysctl -n hw.physmem) / 2)
```

### lagg(4) configuration

```
sysrc ifconfig_em0="up"
sysrc wlans_iwm0="wlan0"
sysrc ifconfig_wlan0="WPA powersave"
sysrc create_args_wlan0="wlanaddr \$(ifconfig em0 ether | awk '/ether/{print \$2}') country de"
sysrc cloned_interfaces="lagg0"
sysrc ifconfig_lagg0="up laggproto failover laggport em0 laggport wlan0 DHCP"
```

### Firefox

Microphone support: set `media.cubeb.backend` to `oss` in about:config. (https://forums.freebsd.org/threads/how-to-use-microphone-with-firefox.74292/#post-485968)

## Git

Sample `~/.gitconfig.local`
---------------------------

```
[includeIf "gitdir:~/rust/"]
    path = ~/.gitconfig-rust
```

### Specifying how to reconcile divergent branches

```
git config pull.rebase false  # merge (the default strategy)
git config pull.rebase true   # rebase                      
git config pull.ff only       # fast-forward only           
```

## macOS

Bootstrapping chezmoi:

```
configuration_file="$HOME/.config/chezmoi/chezmoi.toml"
source_dir="/Volumes/D/dotfiles"
mkdir -p "$(dirname "$configuration_file")"
echo "sourceDir = \"$source_dir\"" > "$configuration_file"
chezmoi init 0mp
```

### Store SSH/GPG passphrases in macOS Keychain

```
echo "UseKeychain yes" >> ~/.ssh/config
```

### Always show file extensions in Finder

Finder has to restart for the setting to apply.

```
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
killall Finder
```

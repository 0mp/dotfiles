dotfiles
========

FreeBSD
-------

```sh
# Add user to the video group.
sudo pw group video -m "${USER}"
```

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

## Other

### `status-bar` development

```
echo ~/.local/bin/status-bar | entr -c -s "date && pkill -SIGUSR1 -F ~/.cache/status-bar.pid"
```

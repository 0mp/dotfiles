lagg(4) configuration
---------------------

```
sysrc ifconfig_em0="up"
sysrc wlans_iwm0="wlan0"
sysrc ifconfig_wlan0="WPA powersave"
sysrc create_args_wlan0="wlanaddr \$(ifconfig em0 ether | awk '/ether/{print \$2}') country de"
sysrc cloned_interfaces="lagg0"
sysrc ifconfig_lagg0="up laggproto failover laggport em0 laggport wlan0 DHCP"
```

Sample `~/.gitconfig.local`
---------------------------

```
[includeIf "gitdir:~/rust/"]
    path = ~/.gitconfig-rust
```

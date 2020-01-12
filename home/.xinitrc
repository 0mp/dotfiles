#! /bin/sh -

clean_up() {
    if [ "$SSH_AGENT_PID" ]; then
        kill "$SSH_AGENT_PID"
    fi

    pkill -F ~/.suckless/status-bar.pid
    pkill -F ~/.suckless/battery-alert.pid
    pkill -F ~/.suckless/eyes-alert.pid
}

trap 'clean_up' EXIT

export LC_ALL=en_US.UTF-8

daemon -p ~/.suckless/status-bar.pid /bin/sh ~/.suckless/status-bar.sh
daemon -p ~/.suckless/battery-alert.pid /bin/sh ~/.suckless/battery-alert.sh
daemon -p ~/.suckless/eyes-alert.pid /bin/sh ~/.suckless/eyes-alert.sh

setxkbmap -option ctrl:nocaps
setxkbmap pl

[ -f ~/.xmodmap ] && xmodmap ~/.xmodmap

sh ~/.fehbg

eval $(ssh-agent -s)

"${@:-dwm}"

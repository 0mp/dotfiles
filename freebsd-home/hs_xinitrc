#! /bin/sh -
#
# NB: In Vim, execute selection with ":terminal sh".

clean_up() {
    if [ "$SSH_AGENT_PID" ]; then
        kill "$SSH_AGENT_PID"
    fi

    pkill -F ~/.cache/sxhkd.pid
    pkill -F ~/.cache/status-bar.pid
    pkill -F ~/.cache/battery-alert.pid
    rm -f -- ~/.cache/battery-alert-off
    pkill -F ~/.cache/eyes-alert.pid
    pkill -F ~/.cache/pie-menu.pid
    pkill -F ~/.cache/inputplug.pid
}

trap 'clean_up' EXIT

export LANG=en_US.UTF-8

mkdir -p ~/.cache
daemon -p ~/.cache/sxhkd.pid sxhkd
daemon -p ~/.cache/status-bar.pid status-bar
daemon -p ~/.cache/battery-alert.pid battery-alert
daemon -p ~/.cache/eyes-alert.pid eyes-alert
daemon -p ~/.cache/pie-menu.pid pie-menu
daemon -p ~/.cache/inputplug.pid inputplug -0 -d -c ~/bin/justctrlnocaps

setxkbmap pl

[ -f ~/.xmodmap ] && xmodmap ~/.xmodmap

feh --no-fehbg --bg-center --image-bg 'black' "${HOME}/.config/desktop/freebsd-logo-by-claudiom.png"

eval $(ssh-agent -s)
gpg-connect-agent reloadagent /bye

$(which dbus-run-session) "${@:-dwm}"

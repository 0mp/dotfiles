xsetroot -name "$(

# Current task
if [ -s ~/.suckless/current-task.txt ]
then
    awk 'NR > 1{printf " -> "} {printf "%s", $0} END{printf " | "}' \
        ~/.suckless/current-task.txt
else
    printf ' '
fi

# Mixer
mixer -s vol | sed 's/\(.*\):[0-9][0-9]*$/\1/'

# Eyes alert
[ -f ~/.0mp-switch/eyes-alert-off ] && printf -- ' | !👓'
printf -- ' | '

# Battery
[ -f ~/.0mp-switch/battery-alert-off ] && printf -- '! '
num_of_batteries="$(sysctl -n hw.acpi.battery.units)"
printf %s "${num_of_batteries}"
if [ -n "${num_of_batteries}" ]
then
    for battery in $( seq 0 "$(( num_of_batteries - 1 ))" )
    do
        if ! acpiconf -i "$battery" | awk '
            /Remaining capacity*/{printf "%s", $3}
            /State:[[:space:]]+charging/{printf "+"}
            /Remaining time:[[:space:]]+.*:.*/{printf " (%s)", $3}'
        then
            printf '%s' '?%'
        fi
        printf %s ' | '
    done
fi

# Networking
active_interface="$(ifconfig lagg0 | awk '/laggport:.*ACTIVE/{print $2}')"
ip_address="$(ifconfig lagg0 | awk '/inet/{print $2}')"
printf -- '%s%s%s' "${active_interface:-...}" "${active_interface:+: }" "${ip_address}"
printf -- ' | '
if drill >/dev/null 2>&1
then
    printf -- '___'
else
    printf -- '_/_'
fi
printf -- ' | '

# Date
date +'%A, %Y-%m-%d (%B) | %H:%M '
)"

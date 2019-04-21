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
for battery in $( seq 0 "$(( $( sysctl -n hw.acpi.battery.units ) - 1 ))" )
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

# Networking
printf -- %s 'wlan0: '
if wpa_cli ping >/dev/null 2>&1
then
    wpa_cli status | awk '
    /^wpa_state=SCANNING$/{printf "..."}
    /^ssid=/{printf "%s, ", substr($0, 6)}
    /^ip_address=/{printf "%s", substr($0, 12)}
    '
else
    printf '%s' '-'
fi
printf -- ' | '
printf -- %s 'em0: '
if ifconfig em0 >/dev/null 2>&1
then
    ifconfig em0 | awk '
    /[[:space:]]*inet /{printf "%s", $2; exit 0}
    {printf "%s", "..."; exit 0}
    '
fi
printf -- ' | '

# Date
date +'%A, %Y-%m-%d (%B) | %H:%M '
)"

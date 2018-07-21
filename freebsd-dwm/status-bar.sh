xsetroot -name "$(
if [ -s ~/.suckless/current-task.txt ]
then
    awk 'NR > 1{printf " -> "} {printf "%s", $0} END{printf " | "}' \
        ~/.suckless/current-task.txt
fi
mixer -s vol | sed 's/\(.*\):[0-9][0-9]*$/\1/'
[ -f ~/.0mp-switch/eyes-alert-off ] && printf -- ' | !👓'
printf -- ' | '
[ -f ~/.0mp-switch/battery-alert-off ] && printf -- '! '
if ! acpiconf -i 0 | awk '
    /Remaining capacity*/{printf "%s", $3}
    /State:[[:space:]]+charging/{printf "+"}
    /Remaining time:[[:space:]]+.*:.*/{printf " (%s)", $3}'
then
    printf '%s' '?%'
fi
printf %s ' | '
if wpa_cli ping >/dev/null 2>&1
then
    wpa_cli status | awk '
    /^ssid=/{printf "%s, ", substr($0, 6)}
    /^ip_address=/{printf "%s", substr($0, 12)}
    '
else
    printf '%s' '-'
fi
printf -- ' | '
date +'%A, %d.%m (%B) | %H:%M '
)"

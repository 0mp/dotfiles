xsetroot -name "$(
if [ -s ~/.suckless/current-task.txt ]
then
    awk 'NR > 1{printf " -> "} {printf "%s", $0} END{printf " | "}' \
        ~/.suckless/current-task.txt
fi
mixer -S vol
[ -f ~/.0mp-switch/eyes-alert-off ] && printf -- ' | !👓'
printf -- ' | '
[ -f ~/.0mp-switch/low-battery-alert-off ] && printf -- '! '
acpiconf -i 0 | awk '\
    /Remaining capacity*/{printf "%s", $3}\
    /State:[[:space:]]+charging/{printf "+"}\
    /Remaining time:[[:space:]]+.*:.*/{printf " (%s)", $3}'
printf -- ' | '
date +'%A, %d.%m | %H:%M'
)"

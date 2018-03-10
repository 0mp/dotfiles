xsetroot -name "$(
if [ -s ~/.0mp-switch/current-task ]
then
    awk 'NR > 1{printf " "} {printf "%s", $0} END{printf " | "}' \
        ~/.0mp-switch/current-task
fi
case "$(date +%M)" in [024][012]) printf -- '👓 | ' ;; esac
mixer -S vol
printf -- ' | '
[ -f ~/.0mp-switch/low-battery-alert-activated ] && printf -- '! '
acpiconf -i 0 | awk '\
    /Remaining capacity*/{printf "%s", $3}\
    /State:[[:space:]]+charging/{printf "+"}\
    /Remaining time:[[:space:]]+.*:.*/{printf " (%s)", $3}'
printf -- ' | '
date +'%A, %d.%m | %H:%M'
)"

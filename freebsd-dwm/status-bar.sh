xsetroot -name "$(
case "$(date +%M)" in [024][012]) printf -- '👓 | ' ;; esac
mixer -S vol
printf -- ' | '
acpiconf -i 0 | awk '\
    /Remaining capacity*/{printf "%s", $3}\
    /State:[[:space:]]+charging/{printf "+"}\
    /Remaining time:[[:space:]]+.*:.*/{printf " (%s)", $3}'
printf -- ' | '
date +'%A, %d.%m | %H:%M'
)"

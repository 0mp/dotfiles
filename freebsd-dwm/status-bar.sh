while true
do
    xsetroot -name "$(
    acpiconf -i 0 | awk '\
        /Remaining capacity*/{printf "%s", $3}\
        /State:[[:space:]]+charging/{printf "+"}\
        /Remaining time:[[:space:]]+.*:.*/{printf " (%s)", $3}'
    printf -- ' | '
    date +'%H:%M | %A, %d.%m'
    )"

    sleep 10
done

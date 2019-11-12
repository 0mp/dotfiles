#! /bin/sh -

run_battery_alert() {
threshold_file="${HOME}/.0mp-switch/battery-alert-threshold"
alert_off_file="${HOME}/.0mp-switch/battery-alert-off"
threshold=15

if [ ! -e "${alert_off_file}" ] && [ -e "${threshold_file}" ]
then
    new_threshold="$(cat -- "${threshold_file}")"
    case ${new_threshold} in
    [0-9][0-9]*)
        threshold="${new_threshold}"
        ;;
    esac
fi

battery_dies() {
    acpiconf -i "$1" | awk -v discharging=no -v threshold="${threshold}" '
        /^State:[[:space:]]+discharging$/ {
            discharging = yes
        }
        /^Remaining capacity:/ {
            capacity = substr($3, 1, length($3) -1)
        }
        END {
            if (int(capacity) < int(threshold)) {
                exit 0
            }
            exit 1
        }'
}
if [ -e "${alert_off_file}" ]
then
    exit 0
fi

# Is it running low on power?
for battery in $( seq 0 "$(( $( sysctl -n hw.acpi.battery.units ) - 1 ))" )
do
    if battery_dies "${battery}"
    then
        continue
    else
        exit 0
    fi
done

touch -- "${alert_off_file}"
button="ALRIGHT I'M ON IT JUST PLEASE DON'T DIE OK?"
xmessage -buttons "${button}" -default "${button}" -file - <<'MESSAGE'
 _   _ _____ _     _     ___    _____ _   _ _____ ____  _____ _
| | | | ____| |   | |   / _ \  |_   _| | | | ____|  _ \| ____| |
| |_| |  _| | |   | |  | | | |   | | | |_| |  _| | |_) |  _| | |
|  _  | |___| |___| |__| |_| |   | | |  _  | |___|  _ <| |___|_|
|_| |_|_____|_____|_____\___/    |_| |_| |_|_____|_| \_\_____(_)

 _____ _   _ _____   ____    _  _____ _____ _____ ______   __
|_   _| | | | ____| | __ )  / \|_   _|_   _| ____|  _ \ \ / /
  | | | |_| |  _|   |  _ \ / _ \ | |   | | |  _| | |_) \ V /
  | | |  _  | |___  | |_) / ___ \| |   | | | |___|  _ < | |
  |_| |_| |_|_____| |____/_/   \_\_|   |_| |_____|_| \_\|_|

 ___ ____    ______   _____ _   _  ____
|_ _/ ___|  |  _ \ \ / /_ _| \ | |/ ___|
 | |\___ \  | | | \ V / | ||  \| | |  _
 | | ___) | | |_| || |  | || |\  | |_| |_
|___|____/  |____/ |_| |___|_| \_|\____(_)

  ____ ___  _   _ _     ____   __   _____  _   _
 / ___/ _ \| | | | |   |  _ \  \ \ / / _ \| | | |
| |  | | | | | | | |   | | | |  \ V / | | | | | |
| |__| |_| | |_| | |___| |_| |   | || |_| | |_| |
 \____\___/ \___/|_____|____/    |_| \___/ \___/

 ____  _     _____    _    ____  _____   ____   ___
|  _ \| |   | ____|  / \  / ___|| ____| |  _ \ / _ \
| |_) | |   |  _|   / _ \ \___ \|  _|   | | | | | | |
|  __/| |___| |___ / ___ \ ___) | |___  | |_| | |_| |
|_|   |_____|_____/_/   \_\____/|_____| |____/ \___/

 ____   ___  __  __ _____ _____ _   _ ___ _   _  ____
/ ___| / _ \|  \/  | ____|_   _| | | |_ _| \ | |/ ___|
\___ \| | | | |\/| |  _|   | | | |_| || ||  \| | |  _
 ___) | |_| | |  | | |___  | | |  _  || || |\  | |_| |
|____/ \___/|_|  |_|_____| |_| |_| |_|___|_| \_|\____|

    _    ____   ___  _   _ _____   ___ _____ ___
   / \  | __ ) / _ \| | | |_   _| |_ _|_   _|__ \
  / _ \ |  _ \| | | | | | | | |    | |  | |   / /
 / ___ \| |_) | |_| | |_| | | |    | |  | |  |_|
/_/   \_\____/ \___/ \___/  |_|   |___| |_|  (_)
MESSAGE
}

acpiconf -i0 >/dev/null || exit 0
while run_battery_alert; do
    sleep 2
done

str="${1}"

: "${BROWSER:=/usr/local/bin/firefox}"
: "${NOHUP:=nohup}"

is_link() {
    printf '%s\n' "${1}" | awk '
    /^[|]/ { sub("^[|]", "", $0) }

    /^[[:space:]]+/ { sub("^[[:space:]]+", "", $0) }

    /^(http|ftp)[s]?:\/\/.*/ { exit 0 }

    /[^[:space:]]+:[0-9]+/ { exit 0 }

    /^[0-9]+[.]/ { exit 0 }

    { exit 1 }
    '
}

open_link() {
    exec ${NOHUP} ${BROWSER} "${1}" >/dev/null 2>&1
}

if is_link "${str}"
then
    link="$(printf %s "${str}" | sed -e 's/^[|]//g' -e 's/^[[:space:]]*//g')"
    open_link "${link}"
else
    open_link "https://duckduckgo.com/?q=!tr ${str}"
    exit 1
fi

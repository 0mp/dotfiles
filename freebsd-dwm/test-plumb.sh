#! /bin/sh -

set -u

BROWSER='echo open_link'
NOHUP=
TESTING=YES
export BROWSER TESTING

test_plumb() {
    local _str _status _out _err

    _str="${1}"
    _status="${2}"
    _out="${3}"
    _err="${4}"

    /usr/local/libexec/atf-check -s "${_status}" -o "${_out}" -e "${_err}" sh ./plumb.sh "${_str}"
}

fail=
open_link_prefix='open_link '
duckduckgo_prefix="${open_link_prefix}https://duckduckgo.com/?q=!tr "

set --
link="https://example.org/About us"
set -- "${@}" "${link}" exit:0 inline:"${open_link_prefix}${link}\\n" empty
link="https://example.org"
set -- "${@}" "${link}" exit:0 inline:"${open_link_prefix}${link}\\n" empty
link="http://example.org"
set -- "${@}" "${link}" exit:0 inline:"${open_link_prefix}${link}\\n" empty
link="http://example.org/u/index.html"
set -- "${@}" "${link}" exit:0 inline:"${open_link_prefix}${link}\\n" empty
link="http://localhost"
set -- "${@}" "${link}" exit:0 inline:"${open_link_prefix}${link}\\n" empty
link="http://localhost"
str="| ${link}"
set -- "${@}" "${str}" exit:0 inline:"${open_link_prefix}${link}\\n" empty
link="http://localhost"
str="|${link}"
set -- "${@}" "${str}" exit:0 inline:"${open_link_prefix}${link}\\n" empty
link="192.168.2.102"
set -- "${@}" "${link}" exit:0 inline:"${open_link_prefix}${link}\\n" empty
link="192.168.2.102:9090/index.html"
set -- "${@}" "${link}" exit:0 inline:"${open_link_prefix}${link}\\n" empty
link="localhost"
set -- "${@}" "${link}" exit:0 inline:"${duckduckgo_prefix}${link}\\n" empty
link="localhost:8080"
set -- "${@}" "${link}" exit:0 inline:"${open_link_prefix}${link}\\n" empty

while [ "${#}" -gt 0 ]
do
    test_plumb "${@}" || fail=true
    shift 4
done

if [ -z "${fail}" ]
then
    echo ok
    exit 0
else
    echo fail
    exit 1
fi

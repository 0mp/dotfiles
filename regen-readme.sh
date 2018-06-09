#! /bin/sh -
#
# Regenerate README.md from dotfiles.1.

set -e

for mandoc in $(which -a mandoc)
do
    if "$mandoc" -Tmarkdown ./dotfiles.1 >/dev/null 2>&1
    then
        "$mandoc" -Tmarkdown ./dotfiles.1 | \
            awk '/# AUTHORS/{exit 0} NR > 2{print $0} ' > README.md.tmp
        mv README.md.tmp README.md
        exit 0
    fi
done
echo 'None of the available mandoc support "-Tmarkdown"' >&2
exit 1

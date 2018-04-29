#! /bin/sh -
#
# Regenerate README.md from dotfiles.1.

set -e

mandoc -Tmarkdown ./dotfiles.1 | awk '/# AUTHORS/{exit 0} NR > 2{print $0} ' > README.md.tmp
mv README.md.tmp README.md

#! /bin/sh -

set -eu

source_path="$(chezmoi source-path)"

ln -f -s "$source_path" ~/.dotfiles

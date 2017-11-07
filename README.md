# Usage

```sh
./setup [module [[option]... --]]...

Modules:

    bash
    freebsd
    git
        --name name
        --email email
    goat
        --defaults
    octave
    switch
    tmux
    ubuntu
    utils
    vim
    x11

    root-freebsd
        --user username
```

## Setup script template

```sh
#! /bin/sh -

. ../lib.sh

set -eu

lib_info 'setup'

FILES=
PREFIX=
CUSTOMFILES=
lib_custom_install() { }
lib_back_up
trap lib_roll_back EXIT
lib_install
trap - EXIT

lib_info 'setup done'
```

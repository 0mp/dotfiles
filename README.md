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
    switch
    thunderbird
    tmux
    ubuntu
    utils
    vim
    x11
```

## Setup script template

```sh
#! /bin/sh -

. ../lib.sh

set -eu

lib_info 'setup'

FILES=''
lib_back_up
trap lib_roll_back EXIT
lib_install
trap - EXIT

lib_info 'setup done'
```

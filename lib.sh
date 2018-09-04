# vi: set ft=sh:

lib_info() {
    printf '%s: %s\n' "$MODULE_NAME" "$*" 1>&2
}

lib_err() {
    lib_info "error: $*"
}

# $1      - The full path to the backed-up file.
# $2      - The name of the backup file in the back up directory.
lib_back_up_file() {
    cp -i -a -v -- "$1" "$BACKUP_DIR/$2"
}

# FILES  - The list of file names (not the full paths).
# CUSTOMFILES - The list of file names, which are installed using
#          lib_custom_install.
# PREFIX - The environemntal variable to modify the destination path of the
#          files. The default prefix is "$HOME/.". For example if you pass
#          PREFIX="$HOME/bin/" then the files from that directory will be
#          backed up.
lib_back_up() {
    lib_info 'backup'
    : ${PREFIX:="$HOME/."}
    for file in $FILES ${CUSTOMFILES:-}
    do
        if [ -e "$PREFIX$file" ]
        then
            lib_back_up_file "$PREFIX$file" "${PREFIX##*/}$file"
        fi
    done
    return 0
}

# $1      - The name of the file inside the backup directory.
# $2      - The full path to the restored path.
lib_roll_back_file() {
    cp -i -a -v -- "$BACKUP_DIR/$1" "$2"
}

# FILES  - The list of file names (not the full paths).
# CUSTOMFILES - The list of file names, which are installed using
#          lib_custom_install.
# PREFIX - The environemntal variable to modify the destination path of the
#          files. The default prefix is "$HOME/.". For example if you pass
#          PREFIX="$HOME/bin/" then the files will be installed to that
#          directory.
lib_roll_back() {
    lib_info 'rollback'
    : ${PREFIX:="$HOME/."}
    set +e
    set +u # Try to restore everyhing you can.
    lib_info roll back due to an error
    for file in $FILES ${CUSTOMFILES:-}
    do
        lib_roll_back_file "${PREFIX##*/}$file" "$PREFIX$file"
    done
    set -eu
}

# $1      - The full path of the source file.
# $2      - The full path of the destination file.
lib_install_file() {
    ln -s -v -f -F -n -- "$1" "$2"
}

# CUSTOMOPTS - The list of options to be passed to lib_custom_install.
# FILES      - The list of file names (not the full paths).
# PREFIX     - The environemntal variable to modify the destination path of the
#              files. The default prefix is "$HOME/.". For example if you pass
#              PREFIX="$HOME/bin/" then the files will be installed to that
#              directory.
#
# lib_custom_install can be a function used to perform custom installation
# process, which is not covered by the standard lib_install and
# lib_install_file functions.
lib_install() {
    lib_info 'install'
    : ${PREFIX:="$HOME/."}
    for file in $FILES
    do
        lib_install_file "$PWD/$file" "$PREFIX$file"
    done
    case "$(type lib_custom_install 2>/dev/null)" in
        lib_custom_install*function*) lib_custom_install ;;
    esac
    return 0
}

lib_require_root() {
    if [ "$(id -u)" -ne 0 ]
    then
        lib_err 'requires root privileges'
        return 1
    fi
}

# PREFIX     - The environemntal variable to modify the destination path of the
#              files. The default prefix is "$HOME/.". For example if you pass
#              PREFIX="$HOME/bin/" then the files will be installed to that
#              directory.
#              Here, the PREFIX directory is created if it's missing.
lib_create_prefix_if_missing() {
    if [ -n "$PREFIX" ] && [ ! -d "${PREFIX%/*}" ]
    then
        mkdir -p -- "${PREFIX%/*}"
    fi
}

# CALLINGUSER - The username using this library. It is handy when root wants to
#               chown some files it created or even run a command as the
#               dotfiles user. Defaults to $USER.
lib_run_as_root() {
    if which sudo > /dev/null 2>&1
    then
        command='sudo'
    else
        lib_info 'sudo is missing; using su'
        command='su root -c'
    fi
    : "${CALLINGUSER:="$USER"}"

    $command env BACKUP_DIR="$BACKUP_DIR" MODULE_NAME="$MODULE_NAME" CALLINGUSER="$CALLINGUSER" sh setup.root "$@"
}

# $1 - File
# $2 - Line
lib_set_once() {
    tmpfile="/tmp/${1##*/}"
    if grep "${2%=*}" -- "$1" >/dev/null
    then
        awk -v regexp="^${2%=*}" -v newline="$2" \
            '{if (match($0, regexp)) print newline; else print}' \
            "$1" > "$tmpfile"
        cat -- "$tmpfile" > "$1"
        rm -- "$tmpfile"
    else
        printf '%s\n' "$2" >> "$1"
    fi
}

# $@ - Packages to install unless they are already installed. The list of
#      packages can be prepended by options to be passed to pkg(8). Those two
#      lists should be separated with "--".
lib_freebsd_install_packages() {
        packages=
        for p in ${*#* -- }
        do
            # $p is a full path to the port. Let's extract the origin.
            p="${p##${p%/*/*}/}"
            if ! pkg info --exists "$p"
            then
                packages="${packages}${packages:+ }${p}"
            fi
        done
        if [ -n "$packages" ]
        then
            pkg install -y ${*% -- *} -- $packages
        fi
}

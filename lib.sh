# vi: set ft=sh:
lib_info() {
    printf '%s: %s\n' "$MODULE_NAME" "$*" 1>&2
}

lib_err() {
    lib_info "error: $*"
}

# $1      - The full path to the backed-up file.
# $2      - The name of the backup file in the back up directory.
# RUNWITH - The environemntal variable with a desired prefix for the body of
#           this function. For example RUNWITH='sudo -E'.
lib_back_up_file() {
    ${RUNWITH:-} cp -i -a -v -- "$1" "$BACKUP_DIR/$2"
}

# FILES  - The list of file names (not the full paths).
# PREFIX - The environemntal variable to modify the destination path of the
#          files. The default prefix is "$HOME/.". For example if you pass
#          PREFIX="~/bin/" then the files from that directory will be backed
#          up.
lib_back_up() {
    : ${PREFIX:="$HOME/."}
    for file in $FILES
    do
        if [ -e "$PREFIX$file" ]
        then
            lib_back_up_file "$PREFIX$file" "$(basename -- $PREFIX)$file"
        fi
    done
    return 0
}

# $1      - The name of the file inside the backup directory.
# $2      - The full path to the restored path.
# RUNWITH - The environemntal variable with a desired prefix for the body of
#           this function. For example RUNWITH='sudo -E'.
lib_roll_back_file() {
    ${RUNWITH:-} cp -i -a -v -- "$BACKUP_DIR/$1" "$2"
}

# FILES  - The list of file names (not the full paths).
# PREFIX - The environemntal variable to modify the destination path of the
#          files. The default prefix is "$HOME/.". For example if you pass
#          PREFIX="~/bin/" then the files will be installed to that directory.
lib_roll_back() {
    : ${PREFIX:="$HOME/."}
    set +e
    set +u # Try to restore everyhing you can.
    lib_info roll back due to an error
    for file in $FILES
    do
        lib_roll_back_file "$(basename -- $PREFIX)$file" "$PREFIX$file"
    done
    set -eu
}

# $1      - The full path of the source file.
# $2      - The full path of the destination file.
# RUNWITH - The environemntal variable with a desired prefix for the body of
#           this function. For example RUNWITH='sudo -E'.
lib_install_file() {
    ${RUNWITH:-} ln -s -v -f -F -n -- "$1" "$2"
}

# FILES  - The list of file names (not the full paths).
# PREFIX - The environemntal variable to modify the destination path of the
#          files. The default prefix is "$HOME/.". For example if you pass
#          PREFIX="~/bin/" then the files will be installed to that directory.
lib_install() {
    : ${PREFIX:="$HOME/."}
    for file in $FILES
    do
        lib_install_file "$PWD/$file" "$PREFIX$file"
    done
}

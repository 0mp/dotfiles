#!/bin/sh

DOTDIR=$PWD
BACKUPDIR="$DOTDIR/backup"
PROMPT='=> '
DOTLIST=".vimrc .tmux.conf .tmux-osx.conf .tmux-linux.conf"
FILE_GITCONFIG=".gitconfig"
FILE_GITCONFIGLOCAL=".gitconfig.local"

# Backup current dotfiles.
perform_backup() {
    echo "-> Backup ..."
    if [ -d "$BACKUPDIR" ]; then
        echo "It looks like some of your dotfiles have already been backed up."
        echo "What would you like me to do then?"
        echo '(m) Backup all the missing dotfiles!'
        echo '(r) Rebackup all my dotfiles!'
        echo "(p) I don't care about backups. Proceed!"
        echo "(e) It's a trap! Stop this script I say!"

        while echo -n "$PROMPT"; read REPLY; do
            case $REPLY in
                m|M)
                    for DOTFILE in $DOTLIST; do
                        if [ -f $BACKUPDIR/$DOTFILE ]; then
                            continue
                        fi
                        cp $HOME/$DOTFILE $BACKUPDIR/$DOTFILE && echo Copied $HOME/$DOTFILE to $BACKUPDIR/$DOTFILE.
                    done
                    break;;
                r|R)
                    rm -rf $BACKUPDIR
                    mkdir $BACKUPDIR
                    for DOTFILE in $DOTLIST; do
                        cp $HOME/$DOTFILE $BACKUPDIR/$DOTFILE && echo Copied $HOME/$DOTFILE to $BACKUPDIR/$DOTFILE.
                    done
                    break;;
                p|P)
                    break;;
                e|E)
                    exit 1;;
                *)
                    echo Huh?;;
            esac
        done
    else
        mkdir $BACKUPDIR

        for DOTFILE in $DOTLIST; do
            cp $HOME/$DOTFILE $BACKUPDIR/$DOTFILE && echo Copied $HOME/$DOTFILE to $BACKUPDIR/$DOTFILE.
        done
    fi
}

make_symbolic_links() {
    echo "-> Removing your dotfiles ..."
    for DOTFILE in $DOTLIST; do
        rm $HOME/$DOTFILE && echo Removed $HOME/$DOTFILE
    done

    echo "-> Creating links to my dotfiles ..."
    for DOTFILE in $DOTLIST; do
        ln -s -v -i $DOTDIR/$DOTFILE $HOME
    done
}

manage_gitconfig() {
    echo "-> Personalising .gitconfig ..."
    echo "Would you like to add your name and email to .gitconfig? (y/n)"
    while echo -n "$PROMPT"; read REPLY; do
        case $REPLY in
            y|Y) REPLY='y'; break;;
            n|N) echo "Fine. I hope you know what you're doing."; REPLY='n' ; break;;
            *) echo Huh?;;
        esac
    done
    if [ "$REPLY" = 'y' ]; then
        touch "$DOTDIR/$FILE_GITCONFIGLOCAL"
        cp "$HOME/$FILE_GITCONFIG" "$BACKUPDIR"
        ln -s -v -i "$DOTDIR/$FILE_GITCONFIGLOCAL" "$HOME/$FILE_GITCONFIG"
        echo "[user]" >> "$DOTDIR/$FILE_GITCONFIGLOCAL"
        echo -n 'Name: '
        read GITUSERNAME
        echo "    name = $GITUSERNAME" >> "$DOTDIR/$FILE_GITCONFIGLOCAL"
        echo -n 'Email: '
        read GITEMAIL
        echo "    email = $GITEMAIL" >> "$DOTDIR/$FILE_GITCONFIGLOCAL"
        echo >> "$DOTDIR/$FILE_GITCONFIGLOCAL"
        echo "[include]" >> "$DOTDIR/$FILE_GITCONFIGLOCAL" >> "$DOTDIR/$FILE_GITCONFIGLOCAL"
        echo "    path = $DOTDIR/$FILE_GITCONFIG" >> "$DOTDIR/$FILE_GITCONFIGLOCAL"
    fi
}

update() {
    git stash
    git pull --rebase
    git stash apply
}

add_vimrclocal() {
    touch "$DOTDIR/.vimrc.local"
    printf "\n\n\n\"\"      Subsection: Local .vimrc\nsource %s/.vimrc.local\n" "$DOTDIR" >> "$DOTDIR/.vimrc"
}

set_up_vim() {
    git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
    cp -r "$DOTDIR/.vim/colors/" "$HOME/.vim/colors"
}

case "$1" in
    backup)
        perform_backup
        ;;
    gitconfig)
        manage_gitconfig
        ;;
    install)
        perform_backup
        make_symbolic_links
        manage_gitconfig
        add_vimrclocal
        set_up_vim
        ;;
    link)
        make_symbolic_links
        ;;
    update)
        update
        ;;
    vim)
        set_up_vim
        ;;
    vimrclocal)
        add_vimrclocal
        ;;
    *)
        echo "Usage: ./manage.sh [backup|gitconfig|install|link|vim|vimrclocal]"
        exit 1
        ;;
esac

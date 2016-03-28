#!/bin/bash

DOTDIR=$PWD
BACKUPDIR="$DOTDIR/backup"
PROMPT='=> '
# DOTLIST=`find . -maxdepth 1 -type f -name '.*' -exec basename {} \;`
DOTLIST=".vimrc .tmux.conf .tmux-osx.conf .tmux-linux.conf .gitconfig"

FILE_GITCONFIG="$DOTDIR/.gitconfig"

echo "DISCLAIMER: This script will:"
echo "(1) Try to backup your dotfiles from this list:"
echo $DOTLIST | tr " " "\n"
echo "(2) Remove these dotfiles from $HOME"
echo "(3) Create links to dotfiles in $DOTDIR directory."
echo "Would you like to proceed? (y/n)"
while echo -n "$PROMPT"; read REPLY; do
    case $REPLY in
        y|Y) echo Watch out guys, we’re dealing with a badass over here!; break;;
        n|N) echo Bye!; exit 1;;
        *) echo Huh?;;
    esac
done
echo

# Backup current dotfiles.
echo "-> Backup ..."
if [ -d "$BACKUPDIR" ]; then
    echo "It looks like some of your dotfiles have already been backed up."
    echo "What would you like me to do then?"
    echo '(m) Backup all the missing dotfile!'
    echo '(r) Rebackup my dotfiles!'
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
echo

echo "-> Removing your dotfiles ..."
for DOTFILE in $DOTLIST; do
    rm $HOME/$DOTFILE && echo Removed $HOME/$DOTFILE
done
echo

echo "-> Creating links to my dotfiles ..."
for DOTFILE in $DOTLIST; do
    ln -s -v -i $DOTDIR/$DOTFILE $HOME
done
echo

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
    echo -n 'User name: '
    read GITUSERNAME
    sed -i -e "s/<inset_your_user_name_here>/$GITUSERNAME/" $FILE_GITCONFIG

    echo -n 'Email: '
    read GITEMAIL
    sed -i -e "s/<insert_your_email_here>/$GITEMAIL/" $FILE_GITCONFIG
fi
echo

echo "-> Done."


#!/bin/bash

DOTDIR=$PWD
BACKUPDIR="$DOTDIR/backup"
PS3='> '
# DOTLIST=`find . -maxdepth 1 -type f -name '.*' -exec basename {} \;`
DOTLIST=".vimrc .tmux.conf"

echo "DISCLAIMER: This script will:"
echo "(1) Try to backup your dotfiles from this list:"
echo $DOTLIST | tr " " "\n"
echo "(2) Remove these dotfiles from $HOME"
echo "(3) Create links to dotfiles in $DOTDIR directory."
echo "Would you like to proceed? (y/n)"
while read REPLY; do
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
    echo "(e) Stop this script! It's a trap!"
    while read REPLY; do
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

echo "-> Done."


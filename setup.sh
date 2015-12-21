#!/bin/bash

DOTDIR=$PWD
BACKUPDIR="$DOTDIR/backup"
PS3='> '
# DOTLIST=`find . -maxdepth 1 -type f -name '.*' -exec basename {} \;`
DOTLIST=".vimrc .tmux.conf"

# Backup current dotfiles.
echo "-> Backup ..."
if [ -d "$BACKUPDIR" ]; then
    echo "It looks like some of your dotfiles have already been backed up."
    echo "I am NOT going to backup anything then. Would you like to proceed? (y/n)"
    while read REPLY; do
        case $REPLY in
            yes|y|Y|YES ) break;;
            no|n|N|NO   ) exit 1;;
            *           ) echo Huh?;;
        esac
    done
else
    mkdir $BACKUPDIR
    for DOTFILE in $DOTLIST; do
        cp $HOME/$DOTFILE $BACKUPDIR/$DOTFILE && echo Copied $HOME/$DOTFILE to $BACKUPDIR/$DOTFILE.
    done
fi

echo "-> Removing your dotfiles :> ..."
for DOTFILE in $DOTLIST; do
    rm $HOME/$DOTFILE && echo Removed $HOME/$DOTFILE
done

echo "-> Creating links to my dotfiles ..."
for DOTFILE in $DOTLIST; do
    ln -s -v -i $DOTDIR/$DOTFILE $HOME
done

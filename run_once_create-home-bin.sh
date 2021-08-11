#! /bin/sh -

set -eu

tempdir=""

if [ -d ~/bin ] && [ ! -L ~/bin ]; then
	tempdir=$(mktemp -d)
	test -d "$tempdir"
	mv ~/bin "$tempdir/"
fi

mkdir -p ~/.local/bin
ln -F -s ~/.local/bin ~/bin

if [ -d "$tempdir" ]; then
	find "$tempdir/bin" -mindepth 1 -maxdepth 1 -exec mv {} ~/.local/bin/ \;
	rmdir "$tempdir/bin"
	rmdir "$tempdir"
fi

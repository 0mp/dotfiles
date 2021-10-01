#! /bin/sh -

set -eu

err() {
	printf '%s\n' "$*" >&2
	exit 1
}

## Environment.

: "${DRYRUN="yes"}"

if [ "$DRYRUN" != yes ]; then
export _DRE=""
else
export _DRE="echo"
echo "This is a dry run..."
fi
BECOME=

require() {
	if ! command -v "$1" >/dev/null; then
		echo "$0: Missing dependency: $1" >&2
		exit 1
	fi
}

block() {
	require makaron
	require realpath

	file="$1"
	input="$(realpath -- "$2")"

	if [ ! -e "$file" ]; then
		$_DRE $BECOME touch -- "$file"
		$_DRE $BECOME chmod 0644 "$file"
	fi
	$_DRE $BECOME makaron --marker "# {mark} $input" \
		--path "$file" --in < "$input"
}

process_() {
	destdir="$1"

	for file in *; do
		spec=${file%%_*}
		if [ "$spec" = "$file" ]; then
			err "Missing spec: $file"
		fi
		target="${file#*_}"

		case $spec in
		*h*)
			target=".$target"
			;;
		esac

		src="$PWD/$file"
		dest="$destdir/$target"

		case $spec in
		*[bc]*[bc]*)
			err "Invalid spec: $file"
			;;
		*b*)
			block "$dest" "$src"
			;;
		*c*)
			"$src" "$dest"
			;;
		esac

		case $spec in
		*[dls]*[dls]*)
			err "Invalid spec: $file"
			;;
		*d*)
			$_DRE $BECOME mkdir -p "$dest"
			(cd "$file" && process_ "$dest")
			;;
		*D*)
			$_DRE $BECOME mkdir -p "$dest"
			(cd "$file" && process_ "$dest")
			;;
		*l*)
			$_DRE $BECOME ln -Ffnv -- "$src" "$dest"
			;;
		*s*)
			$_DRE $BECOME ln -Ffnsv -- "$src" "$dest"
			;;
		esac

		case $spec in
		*m[0-7][0-7][0-7]*)
			mode=$(expr -- "$spec" : '.*m\([0-7][0-7][0-7]\).*')
			$_DRE $BECOME chmod -- "$mode" "$dest"
			;;
		*m*)
			err "Invalid spec: $file"
			;;
		esac
	done
}

case $1 in
	freebsd-laptop|freebsd-system)
		require sudo
		export BECOME=sudo
		cd "$1" && process_ "/"
		;;
	*)
		err "Invalid installation target: $1"
		;;
esac

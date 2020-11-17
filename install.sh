#! /bin/sh -

set -eu

err() {
	printf '%s\n' "$*" >&2
	exit 1
}

## Environment.

: "${DRYRUN="yes"}"

if [ "$DRYRUN" != no ]; then
export _DRE="echo"
else
export _DRE=""
fi

require() {
	if ! command -v "$1" >/dev/null; then
		echo "$0: Missing dependency: $1" >&2
		exit 1
	fi
}

block() {
	require makaron

	file="$1"
	input="$2"

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

		dest="$destdir/$target"

		case $spec in
		*[bc]*[bc]*)
			err "Invalid spec: $file"
			;;
		*b*)
			block "$dest" "$PWD/$file"
			;;
		*c*)
			"$PWD/$file" "$dest"
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
			$_DRE $BECOME ln -Ffhv -- "$file" "$dest"
			;;
		*s*)
			$_DRE $BECOME ln -Ffhsv -- "$file" "$dest"
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
	essential | freebsd-home)
		cd "$1" && process_ "$HOME"
		;;
	freebsd-laptop|freebsd-system)
		require sudo
		export BECOME=sudo
		cd "$1" && process_ "/"
		;;
	firefox)
		if [ ! -f "$HOME/.mozilla/firefox/profiles.ini" ]; then
			err "profiles.ini is missing; run firefox at least once"
		fi
		profile="$(awk -f = '/^default=.*[.].*/{print $2; exit}' ${HOME}/.mozilla/firefox/profiles.ini)"
		$_DRE ln -f -s ./firefox/user.js "${HOME}/.mozilla/firefox/${profile}/user.js"
		;;
	*)
		err "Invalid installation target: $1"
		;;
esac

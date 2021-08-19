#! /bin/sh -

set -eu

# Usage: get_profile profiles_ini
get_profile() {
	_profiles_ini="$1"
	awk -F = '
		/^Default=.*[.].*/ {
			profile = $2
		}
		END {
			if (profile == "")
				exit 1
			else
				print(profile)
		}
	' "$_profiles_ini"
}

custom_config_dir="$HOME/.config/desktop/firefox"
firefox_dir="$HOME/.mozilla/firefox"
profiles_ini="$firefox_dir/profiles.ini"

if [ ! -f "$profiles_ini" ]; then
	echo "profiles.ini is not present; Firefox will not be configured this time" >&2
fi

profile_name="$(get_profile "$profiles_ini")"
profile_dir="$firefox_dir/$profile_name"

# Install user.js.
ln -f -s "$custom_config_dir/user.js" "$profile_dir/user.js"

# Install userChrome.css.
mkdir -p "$profile_dir/chrome"
ln -f -s "$custom_config_dir/chrome/userChrome.css" "$profile_dir/chrome/userChrome.css"

set -eux

user="$1"

# Install packages.
packages='
bash
bash-completion
firefox
git
sudo
tmux
vim
xclip
xorg
'
pkg install -y -- $packages

# Download dotfiles.
dotfilesurl='https://github.com/0mp/dotfiles'
dotfilesdir="/home/$user/.dotfiles"
if ! [ -d "$dotfilesdir" ]; then
    su "$user" -c git clone "$dotfilesurl" "$dotfilesdir"
fi

# Enable sudo for the wheel group.
printf '%s\n' 'g/# %wheel ALL=(ALL) ALL/s//%wheel ALL=(ALL) ALL/' 'w' | \
    EDITOR='ed -s' visudo

# Change the login shell to Bash.
chsh -s bash "$user"

# Configure pkg to use the "latest" branch instead of the "quaterly"
# one.
pkgconfdir='/usr/local/etc/pkg/repos'
pkgconf="$pkgconfdir/FreeBSD.conf"
mkdir -p -- "$pkgconfdir"
if ! [ -f "$pkgconf" ]
then
    cat > "$pkgconf" <<'EOF'
FreeBSD: {
  url: "pkg+http://pkg.FreeBSD.org/${ABI}/latest",
  mirror_type: "srv",
  signature_type: "fingerprints",
  fingerprints: "/usr/share/keys/pkg",
  enabled: yes
}
EOF
fi

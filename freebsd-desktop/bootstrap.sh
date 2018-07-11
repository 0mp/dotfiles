# SPDX-License-Identifier: BSD-2-Clause-FreeBSD
#
# Copyright (c) 2018 Mateusz Piotrowski <0mp@FreeBSD.org>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
# ---
# Version: 0.1
set -eux

user="$1"

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
ASSUME_ALWAYS_YES=YES pkg bootstrap
pkg install -y -- $packages

# Download dotfiles.
dotfilesurl='https://github.com/0mp/dotfiles'
dotfilesdir="/home/$user/.dotfiles"
if ! [ -d "$dotfilesdir" ]; then
    su "$user" -c "git clone '$dotfilesurl' '$dotfilesdir'"
fi

# Enable sudo for the wheel group.
printf '%s\n' 'g/# %wheel ALL=(ALL) ALL/s//%wheel ALL=(ALL) ALL/' 'w' | \
    EDITOR='ed -s' visudo

# Change the login shell to Bash.
chsh -s bash "$user"

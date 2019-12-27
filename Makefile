.MAIN: dotfiles

dotfiles: xpdf .PHONY

freebsd: dotfiles freebsd-user .PHONY

##############################################################################

freebsd-user: .PHONY
	ln -f "${.CURDIR}/home/.login_conf" "${HOME}/.login_conf"

##############################################################################

xpdf: .PHONY
	ln -f -s "${.CURDIR}/home/.xpdfrc" "${HOME}/.xpdfrc"

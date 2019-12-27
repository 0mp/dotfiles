.MAIN: dotfiles

dotfiles: octave utils xmodmap xpdf .PHONY

freebsd: dotfiles freebsd-user .PHONY

##############################################################################

freebsd-user: .PHONY
	ln -f ${.CURDIR}/home/.login_conf ${HOME}/.login_conf

##############################################################################

octave: .PHONY
	ln -f ${.CURDIR}/home/.octaverc ${HOME}/.octaverc

##############################################################################

utils: .PHONY
	mkdir -p ${HOME}/.local/bin
	mkdir -p ${HOME}/.local/share/man/man1
	mkdir -p ${HOME}/.local/share/man/man8
	ln -f -s ${HOME}/.local/bin ~/bin

	ln -f -s ${.CURDIR}/home/.local/share/man/man1/0mp-explore.1 ${HOME}/.local/share/man/man1/0mp-explore.1
	ln -f -s ${.CURDIR}/home/.local/bin/0mp-explore ${HOME}/.local/bin/0mp-explore
	ln -f -s ${.CURDIR}/home/.local/bin/cflowfilter ${HOME}/.local/bin/cflowfilter
	ln -f -s ${.CURDIR}/home/.local/bin/committer-bootstrap ${HOME}/.local/bin/committer-bootstrap
	ln -f -s ${.CURDIR}/home/.local/bin/disable-yoga-3-14-touchscreen ${HOME}/.local/bin/disable-yoga-3-14-touchscreen
	ln -f -s ${.CURDIR}/home/.local/bin/faf ${HOME}/.local/bin/faf
	ln -f -s ${.CURDIR}/home/.local/bin/flip-git-remote-url ${HOME}/.local/bin/flip-git-remote-url
	ln -f -s ${.CURDIR}/home/.local/bin/get-list-of-ports-for-moinmoin ${HOME}/.local/bin/get-list-of-ports-for-moinmoin
	ln -f -s ${.CURDIR}/home/.local/bin/manlint ${HOME}/.local/bin/manlint
	ln -f -s ${.CURDIR}/home/.local/bin/previewman ${HOME}/.local/bin/previewman
	ln -f -s ${.CURDIR}/home/.local/bin/radio ${HOME}/.local/bin/radio
	ln -f -s ${.CURDIR}/home/.local/bin/resizetty ${HOME}/.local/bin/resizetty
	ln -f -s ${.CURDIR}/home/.local/bin/samsung2043nw ${HOME}/.local/bin/samsung2043nw
	ln -f -s ${.CURDIR}/home/.local/bin/superdrive ${HOME}/.local/bin/superdrive
	ln -f -s ${.CURDIR}/home/.local/bin/test-true-color-support ${HOME}/.local/bin/test-true-color-support

##############################################################################

xmodmap: .PHONY
	ln -f -s ${.CURDIR}/home/.xmodmap ${HOME}/.xmodmap

##############################################################################

xpdf: .PHONY
	ln -f -s ${.CURDIR}/home/.xpdfrc ${HOME}/.xpdfrc

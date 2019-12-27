.MAIN: dotfiles

dotfiles: octave subversion tmux utils xmodmap xpdf .PHONY

freebsd: dotfiles freebsd-user .PHONY

##############################################################################

freebsd-user: .PHONY
	ln -f ${.CURDIR}/home/.login_conf ${HOME}/.login_conf

##############################################################################

octave: .PHONY
	ln -f -s ${.CURDIR}/home/.octaverc ${HOME}/.octaverc

##############################################################################

subversion: .PHONY
	mkdir -p ${HOME}/.subversion
	ln -f -s ${.CURDIR}/home/.subversion/config ${HOME}/.subversion/config

##############################################################################

tmux: .PHONY
	ln -f -s ${.CURDIR}/home/.tmux.conf ${HOME}/.tmux.conf
	ln -f -s ${.CURDIR}/home/.tmux-freebsd.conf ${HOME}/.tmux-freebsd.conf
	ln -f -s ${.CURDIR}/home/.tmux-macos.conf ${HOME}/.tmux-macos.conf

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

	ln -f -s ${.CURDIR}/home/.local/bin/flip-svn-location ${HOME}/.local/bin/flip-svn-location
	ln -f -s ${.CURDIR}/home/.local/bin/fr ${HOME}/.local/bin/fr
	ln -f -s ${.CURDIR}/home/.local/bin/justmount ${HOME}/.local/bin/justmount
	ln -f -s ${.CURDIR}/home/.local/share/man/man8/muchup.8 ${HOME}/.local/share/man/man8/muchup.8
	ln -f -s ${.CURDIR}/home/.local/bin/muchup ${HOME}/.local/bin/muchup
	ln -f -s ${.CURDIR}/home/.local/bin/nycbug-dmesgd ${HOME}/.local/bin/nycbug-dmesgd
	ln -f -s ${.CURDIR}/home/.local/bin/ports ${HOME}/.local/bin/ports
	ln -f -s ${.CURDIR}/home/.local/bin/unitek-init ${HOME}/.local/bin/unitek-init
	ln -f -s ${.CURDIR}/home/.local/bin/wifi-init ${HOME}/.local/bin/wifi-init

##############################################################################

xmodmap: .PHONY
	ln -f -s ${.CURDIR}/home/.xmodmap ${HOME}/.xmodmap

##############################################################################

xpdf: .PHONY
	ln -f -s ${.CURDIR}/home/.xpdfrc ${HOME}/.xpdfrc

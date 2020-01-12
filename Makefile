.MAIN: dotfiles

dotfiles: awesome bash git octave subversion tmux utils vim xmodmap xmonad xpdf .PHONY

desktop: dwm .PHONY

freebsd: dotfiles freebsd-user .PHONY

##############################################################################

awesome: .PHONY
	mkdir -p ${HOME}/.config/awesome
	ln -f -s ${.CURDIR}/home/.config/awesome/rc.lua ${HOME}/.config/awesome/rc.lua

##############################################################################

bash: .PHONY
	ln -f -s ${.CURDIR}/home/.bashrc ${HOME}/.bashrc
	ln -f -s ${.CURDIR}/home/.bash_profile ${HOME}/.bash_profile
	ln -f -s ${.CURDIR}/home/.bash_completion ${HOME}/.bash_completion
	ln -f -s ${.CURDIR}/home/.inputrc ${HOME}/.inputrc

##############################################################################

${HOME}/h/dwm:
	mkdir -p ${HOME}/h
	git clone http://github.com/0mp/dwm ${.TARGET}

dwm: .PHONY
	pkg info -q libX11 libXft libXinerama fontconfig || \
		sudo pkg install -Ay libX11 libXft libXinerama fontconfig
	make -C ${HOME}/h/dwm clean dwm install

	ln -f -s ${.CURDIR}/home/.xinitrc ${HOME}/.xinitrc
	mkdir -p ${HOME}/.local/bin
	ln -f -s ${.CURDIR}/home/.local/bin/battery-alert ${HOME}/.local/bin/battery-alert
	ln -f -s ${.CURDIR}/home/.local/bin/eyes-alert ${HOME}/.local/bin/eyes-alert
	ln -f -s ${.CURDIR}/home/.local/bin/status-bar ${HOME}/.local/bin/status-bar
	mkdir -p ${HOME}/.config/dwm
	ln -f -s ${.CURDIR}/home/.config/dwm/freebsd-logo-by-claudiom.png ${HOME}/.config/dwm/freebsd-logo-by-claudiom.png

##############################################################################

freebsd-user: .PHONY
	ln -f ${.CURDIR}/home/.login_conf ${HOME}/.login_conf

##############################################################################

git: .PHONY
	ln -f -s ${.CURDIR}/home/.gitconfig ${HOME}/.gitconfig

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
	ln -f -s ${.CURDIR}/home/.local/bin/current-task ${HOME}/.local/bin/current-task

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

vim: .PHONY
	ln -f -s ${.CURDIR}/home/.vimrc ${HOME}/.vimrc

	mkdir -p ${HOME}/.vim/templates
	ln -f -s ${.CURDIR}/home/.vim/templates/Makefile ${HOME}/.vim/templates/Makefile

##############################################################################

xmodmap: .PHONY
	ln -f -s ${.CURDIR}/home/.xmodmap ${HOME}/.xmodmap

##############################################################################

xmonad: .PHONY
	mkdir -p ${HOME}/.xmonad
	ln -f -s ${.CURDIR}/home/.xmonad/xmonad.hs ${HOME}/.xmonad/xmonad.hs
	ln -f -s ${.CURDIR}/home/.xmobarrc ${HOME}/.xmobarrc

##############################################################################

xpdf: .PHONY
	ln -f -s ${.CURDIR}/home/.xpdfrc ${HOME}/.xpdfrc

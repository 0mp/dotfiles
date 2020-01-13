.MAIN: dotfiles

dotfiles: awesome bash goat git octave subversion sxhkd tmux utils vim xmodmap xmonad xpdf .PHONY

desktop: dwm .PHONY

freebsd: dotfiles freebsd-user .PHONY

##############################################################################

awesome: .PHONY
	mkdir -p ${HOME}/.config/awesome
	${__symlink_home} .config/awesome/rc.lua

##############################################################################

bash: .PHONY
	${__symlink_home} .bashrc
	${__symlink_home} .bash_profile
	${__symlink_home} .bash_completion
	${__symlink_home} .inputrc

##############################################################################

${HOME}/h/dwm:
	mkdir -p ${HOME}/h
	git clone http://github.com/0mp/dwm ${.TARGET}

dwm: ${HOME}/h/dwm .PHONY
	pkg info -q libX11 libXft libXinerama fontconfig || \
		sudo pkg install -Ay libX11 libXft libXinerama fontconfig
	make -C ${HOME}/h/dwm clean dwm install

	${__symlink_home} .xinitrc
	mkdir -p ${HOME}/.local/bin
	${__symlink_home} .local/bin/battery-alert
	${__symlink_home} .local/bin/eyes-alert
	${__symlink_home} .local/bin/status-bar
	mkdir -p ${HOME}/.config/dwm
	${__symlink_home} .config/dwm/freebsd-logo-by-claudiom.png
	${__symlink_home} .config/dwm/plumb.sh

##############################################################################

freebsd-user: .PHONY
	ln -f ${.CURDIR}/home/.login_conf ${HOME}/.login_conf

##############################################################################

${HOME}/h/goat:
	mkdir -p ${HOME}/h
	git clone http://github.com/0mp/goat ${.TARGET}

goat: ${HOME}/h/goat .PHONY
	make -C ${HOME}/h/goat clean install

##############################################################################

git: .PHONY
	${__symlink_home} .gitconfig

##############################################################################

octave: .PHONY
	${__symlink_home} .octaverc

##############################################################################

subversion: .PHONY
	mkdir -p ${HOME}/.subversion
	${__symlink_home} .subversion/config

##############################################################################

sxhkd: .PHONY
	mkdir -p ${HOME}/.config/sxhkd
	${__symlink_home} .config/sxhkd/sxhkdrc

##############################################################################

tmux: .PHONY
	${__symlink_home} .tmux.conf
	${__symlink_home} .tmux-freebsd.conf
	${__symlink_home} .tmux-macos.conf

##############################################################################

utils: .PHONY
	mkdir -p ${HOME}/.local/bin
	mkdir -p ${HOME}/.local/share/man/man1
	mkdir -p ${HOME}/.local/share/man/man8
	${__symlink_home} bin

	${__symlink_home} .local/share/man/man1/0mp-explore.1
	${__symlink_home} .local/bin/0mp-explore
	${__symlink_home} .local/bin/cflowfilter
	${__symlink_home} .local/bin/colors
	${__symlink_home} .local/bin/committer-bootstrap
	${__symlink_home} .local/bin/disable-yoga-3-14-touchscreen
	${__symlink_home} .local/bin/faf
	${__symlink_home} .local/bin/flip-git-remote-url
	${__symlink_home} .local/bin/get-list-of-ports-for-moinmoin
	${__symlink_home} .local/bin/manlint
	${__symlink_home} .local/bin/previewman
	${__symlink_home} .local/bin/radio
	${__symlink_home} .local/bin/resizetty
	${__symlink_home} .local/bin/samsung2043nw
	${__symlink_home} .local/bin/superdrive
	${__symlink_home} .local/bin/test-true-color-support
	${__symlink_home} .local/bin/current-task

	${__symlink_home} .local/bin/flip-svn-location
	${__symlink_home} .local/bin/fr
	${__symlink_home} .local/bin/justmount
	${__symlink_home} .local/share/man/man8/muchup.8
	${__symlink_home} .local/bin/muchup
	${__symlink_home} .local/bin/nycbug-dmesgd
	${__symlink_home} .local/bin/ports
	${__symlink_home} .local/bin/unitek-init
	${__symlink_home} .local/bin/wifi-init

##############################################################################

vim: .PHONY
	${__symlink_home} .vimrc

	mkdir -p ${HOME}/.vim/templates
	${__symlink_home} .vim/templates/Makefile

##############################################################################

xmodmap: .PHONY
	${__symlink_home} .xmodmap

##############################################################################

xmonad: .PHONY
	mkdir -p ${HOME}/.xmonad
	${__symlink_home} .xmonad/xmonad.hs
	${__symlink_home} .xmobarrc

##############################################################################

xpdf: .PHONY
	${__symlink_home} .xpdfrc

##############################################################################
##############################################################################
##############################################################################

__symlink_home=	@sh -eu -c 'ln -fsv "${.CURDIR}/home/$${1}" $${HOME}/$${1}' __symlink_home

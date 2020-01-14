.MAIN: dotfiles

dotfiles: .PHONY
	${MAKE} awesome bash goat git octave subversion sxhkd tmux utils vim xmodmap xmonad xpdf ${.TARGETS:Mpackages}

freebsd: dotfiles .PHONY
	${MAKE} desktop dwm freebsd-user ${.TARGETS:Mpackages}

##############################################################################

awesome: .PHONY
	mkdir -p ${HOME}/.config/awesome
	${__symlink_home} .config/awesome/rc.lua

##############################################################################

bash_PACKAGES=	bash bash-completion

bash: .PHONY
	${__symlink_home} .bashrc
	${__symlink_home} .bash_profile
	${__symlink_home} .bash_completion
	${__symlink_home} .inputrc

##############################################################################

desktop_PACKAGES=	mosh entr git subversion firefox moinmoincli xpdf sxhkd \
			sct feh find-cursor intel-backlight

desktop: .PHONY
	# nothing

##############################################################################

dwm_PACKAGES=	git libX11 libXft libXinerama fontconfig \
		alacritty dmenu

${HOME}/h/dwm:
	mkdir -p ${HOME}/h
	git clone http://github.com/0mp/dwm ${.TARGET}

dwm: packages .WAIT ${HOME}/h/dwm .PHONY
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

goat_PACKAGES=	git

${HOME}/h/goat:
	mkdir -p ${HOME}/h
	git clone http://github.com/0mp/goat ${.TARGET}

goat: ${HOME}/h/goat .PHONY
	make -C ${HOME}/h/goat clean install

##############################################################################

git_PACKAGES=	git

git: .PHONY
	${__symlink_home} .gitconfig

##############################################################################

octave: .PHONY
	${__symlink_home} .octaverc

##############################################################################

subversion_PACKAGES=	subversion

subversion: .PHONY
	mkdir -p ${HOME}/.subversion
	${__symlink_home} .subversion/config

##############################################################################

sudo: .PHONY
.if "${:!command -v sudo!}" == ""
	su root -c "env ASSUME_ALWAYS_YES=yes pkg install -y sudo"
	su root -c visudo
.endif

##############################################################################

sxhkd: .PHONY
	mkdir -p ${HOME}/.config/sxhkd
	${__symlink_home} .config/sxhkd/sxhkdrc

##############################################################################

tmux_PACKAGES=	tmux

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

vim_PACKAGES=	py37-black vim

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

.for _target in ${.TARGETS}
INSTALLED_PACKAGES+=	${:!pkg query %n ${${_target}_PACKAGES} || true!}
.endfor
.for _target in ${.TARGETS}
_packages=	${${_target}_PACKAGES:O:u}
.	for _installed_package in ${INSTALLED_PACKAGES}
_packages:= ${_packages:N${_installed_package}}
.	endfor
PACKAGES+=	${_packages}
.endfor

packages: sudo .PHONY
.if make(packages)
	sudo pkg install -y ${PACKAGES:O:u}
.endif

# NAME

**dotfiles** - various configuration scripts, dotfiles and utilities

# SYNOPSIS

**./setup**
\[*module* \[\[*option ...*] **--**] *...*]

# DESCRIPTION

**dotfiles**
is a framework to manage configuration scripts, dotfiles and utilities.

The modules are as follows:

**bash**

> Install Bash
> configuration files.

**firefox**

> Configure Firefox with
> *user.js*.

**freebsd-current**

> Configure a
> FreeBSD
> machine running CURRENT.
> This module sets some development-specific variables in
> make.conf(5),
> src.conf(5),
> and
> src-env.conf(5).

**freebsd-desktop** \[*option ...*]

> Configuration files for a
> FreeBSD
> desktop.

> **--fonts**

> > Install and configure additional fonts.

> **--ntpd**

> > Configure
> > ntpd(8)
> > to set correct time at system startup.

> **--powerdxx**

> > Install powerd++ for a better power management than the one offered by
> > powerd(8).

**freebsd-dwm** \[*option ...*]

> Configuration of a desktop environment running the dwm window manager.
> The options are as follows:

> **--install**

> > Recompile and reinstall dwm.

> **--wallpaper**

> > Set up a wallpaper using feh.
> > This option succeeds only when Xorg is running.

**freebsd-e5500**

> Configure
> FreeBSD
> desktop experience for Dell Latitude E5500.
> The options are as follows:

> **--intel**

> > Install Intel driver for Xorg.

> **--wifi**

> > Configure wireless networking.

**freebsd-general**

> Install some
> FreeBSD
> general purpose utilities and configuration files.

**freebsd-haseeq540s**

> Configure
> FreeBSD
> desktop experience for Hasee Q540S.

**freebsd-l702x** \[*option ...*]

> Configure
> FreeBSD
> desktop experience for Dell XPS L702X.
> The options are as follows:

> **--nvidia**

> > Install an Nvidia graphics driver.

**freebsd-st**

> Configure the st terminal.
> The options are as follows:

> **--install**

> > Recompile and reinstall st.

**freebsd-yoga314** \[*option ...*]

> Configure
> FreeBSD
> desktop experience for Lenovo Yoga 3 14.
> The options are as follows:

> **--intel**

> > Install Intel graphics kernel modules.

**git** \[*option ...*]

> Configure Git.
> The options are as follows:

> **--email** *email*

> > The email to set in
> > *~/.gitconfig*.
> > Defaults to
> > '0mp@FreeBSD.org'.

> **--github-ssh**

> > Configure Git to replace
> > "`https://github.com/`"
> > with
> > "`ssh://git@github.com/`"
> > so that SSH is used even if a repository is configured to use HTTPS.

> **--name** *name*

> > The name to set in
> > *~/.gitconfig*.
> > Defaults to
> > 'Mateusz Piotrowski'.

**gnupg**

> Install GnuPG configuration files.

**goat** \[**--defaults**]

> Install goat.
> Using
> **--defaults**
> populates goat with some default shortcuts.

**macos** \[*option ...*]

> Configure macOS.
> The options are as follows:

> **--bash**

> > Install Bash 4 with Homebrew.

**octave**

> Instal octave-cli configuration files.

**subversion**

> Install Subversion configuration files.

**tmux**

> Install tmux configuration files.

**utils**

> Install general purpose utilities.

**vim**

> Configure Vim and install related configuration files.

**x11**

> Install Xorg-related configuration files.

**xpdf**

> Install Xpdf configuration files.

# EXAMPLES

Install
**bash**
and
**git**
modules:

	./setup bash git --name 'Charlie Root' --email 'root@example.org' --


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

**freebsd-desktop** \[\[*option ...*] **--**]

> Configuration files for a
> FreeBSD
> desktop.

> **--fonts**

> > Install and configure additional fonts.

**freebsd-dwm** \[\[*option ...*] **--**]

> Configuration of a desktop environment running the dwm window manager.
> The options are as follows:

> **--install**

> > Recompile and reinstall dwm.

> **--wallpaper**

> > Set up a wallpaper using feh.
> > This option succeeds only when Xorg is running.

**freebsd-current**

> Configure a
> FreeBSD
> machine running CURRENT.
> This module sets some development-specific variables in
> make.conf(5),
> src.conf(5),
> and
> src-env.conf(5).

**freebsd-general**

> Install some
> FreeBSD
> general purpose utilities and configuration files.

**freebsd-l702x** \[\[*option ...*] **--**]

> Configure
> FreeBSD
> desktop experience for Dell XPS L702X.
> The options are as follows:

> **--nvidia**

> > Install an Nvidia graphics driver.

**freebsd-laptop** \[\[*option ...*] **--**]

> Configure
> FreeBSD
> on a laptop.

> Supported models are:

> **--haseeq540s**

> > Hasee Q540S

> **--t480**

> > Lenovo ThinkPad T480

**freebsd-st** \[\[*option ...*] **--**]

> Configure the st terminal.
> The options are as follows:

> **--install**

> > Recompile and reinstall st.

> **--low-resolution**

> > Use smaller default font.

**freebsd-yoga314** \[\[*option ...*] **--**]

> Configure
> FreeBSD
> desktop experience for Lenovo Yoga 3 14.
> The options are as follows:

> **--intel**

> > Install Intel graphics kernel modules.

**git** \[\[*option ...*] **--**]

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

**goat** \[\[*option ...*] **--**]

> Install goat.
> The options are as follows:

> **--defaults**

> > Populate goat with some default shortcuts.

**macos** \[\[*option ...*] **--**]

> Configure macOS.
> The options are as follows:

> **--bash**

> > Install Bash 4 with Homebrew.

**octave**

> Instal octave-cli configuration files.

**subversion**

> Install Subversion configuration files.

**tmux** \[\[*option ...*] **--**]

> Install tmux configuration files.
> The options are as follows:

> **--freebsd**

> > Make
> > `pane_current_path`
> > work for unprivileged users on
> > FreeBSD.

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


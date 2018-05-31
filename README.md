# NAME

**dotfiles** - various configuration scripts, dotfiles and utilities by 0mp

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

**freebsd-current**

> Configure a
> FreeBSD
> machine running CURRENT.
> This module sets some development-specific variables in
> make.conf(5),
> src.conf(5),
> and
> src-env.conf(5).

**freebsd-desktop**

> Configuration files for a
> FreeBSD
> desktop.

**freebsd-dwm** \[**--install**]

> Configuration of a desktop environment running the dwm window manager.
> Using
> **--install**
> causes dwm to be recompiled and reinstalled.

**freebsd-general**

> Install some
> FreeBSD
> general purpose utilities and configuration files.

**freebsd-st**

> Recompile and reinstall st terminals.

**freebsd-yoga314** \[*option ...*]

> Configure
> FreeBSD
> desktop experience for Lenovo Yoga 3 14.
> The options are as follows:

> **--fonts**

> > Install additional fonts.

> **--intel**

> > Install Intel graphics kernel modules.

> **--powerdxx**

> > Install powerd++ for a better power management than the one offered by
> > powerd(8)

**git** \[*option ...*]

> Configure Git.
> The options are as follows:

> **--name** *name*

> > The name to set in
> > *~/.gitconfig*.
> > Unless specified, the module interactively prompts for the name during
> > installation.

> **--email** *email*

> > The email to set in
> > *~/.gitconfig*.
> > Unless specified, the module interactively prompts for the email during
> > installation.

> **--github-ssh**

> > Configure Git to replace
> > "`https://github.com/`"
> > with
> > "`ssh://git@github.com/`"
> > so that SSH is used even if a repository is configured to use HTTPS.

**goat** \[**--defaults**]

> Install goat.
> Using
> **--defaults**
> populates goat with some default shortcuts.

**octave**

> Instal octave-cli configuration files.

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


# vim: filetype=bash softtabstop=4 shiftwidth=4 tabstop=4 expandtab
# Add some directories to the *PATH unless they are already there.
case "$PATH" in
    *$HOME/.local/bin*) ;;
    *) PATH="$HOME/.local/bin:$PATH" ;;
esac
case "$MANPATH" in
    *$HOME/.local/share/man*) ;;
    *) MANPATH="$HOME/.local/share/man:$MANPATH" ;;
esac

# Configure history.
HISTCONTROL=ignoredups:erasedups
HISTSIZE=20000

# C-s and C-q key bindings for the flow control should be off by default.
# http://stackoverflow.com/a/6951487/4694621
stty -ixon -ixoff

# Check the window size after each command and, if necessary, update the
# values of LINES and  COLUMNS.
shopt -s checkwinsize

# Aliases & functions
alias w3m="w3m -v"
ddg() {
    local search="/?q=$*"
    command w3m -X "ddg.gg${search%%/?q=}"
}

man() {
    # Make manpages fit the screen even if it's very small.
    MANWIDTH="$((COLUMNS < 80 ? (COLUMNS - 2) : 78))" command man "$@"
}

tmux_clear_detached_sessions() {
    tmux list-sessions | grep -E -v '\(attached\)$' | while IFS='\n' read line; do
        tmux kill-session -t "${line%%:*}"
    done
}

ssh_agent_activate() {
    eval $(ssh-agent)
    ssh-add
}

# Although the default color is blue, it is possible to configure the prompt to
# use a different color by setting PS1 before sourcing this file. For example,
# setting it to '41' results in a red prompt.
case $PS1 in
    [0-9][0-9]) ;;
    *) PS1='44'
esac
PS1="\[\e[1;37;${PS1}m"'\] $? \[\e[0m\] \u@\h $PWD\n'

if [[ -n $PS1 ]] && [[ $- == *i* ]]
then
    case $OSTYPE in
        darwin*)
            # Remember to install bash-completion@2 using brew.
            if [[ -r /usr/local/share/bash-completion/bash_completion ]]; then
                source /usr/local/share/bash-completion/bash_completion
            fi
            ;;
        freebsd*)
            if [[ -r /usr/local/share/bash-completion/bash_completion.sh ]]
            then
                source /usr/local/share/bash-completion/bash_completion.sh
            fi
            if type -P fzf >/dev/null
            then
                source /usr/local/share/examples/fzf/shell/completion.bash
                source /usr/local/share/examples/fzf/shell/key-bindings.bash
            fi
            ;;
    esac
fi

export CLICOLOR='YES'
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export LESS='--ignore-case --jump-target=3 --RAW-CONTROL-CHARS'
export MANPAGER="$PAGER --squeeze-blank-lines --RAW-CONTROL-CHARS"

[[ -x ~/.local/bin/goat ]] && . "/home/0mp/.local/share/goat/libgoat.sh"

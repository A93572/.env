# .bashrc

## Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

## Source custom alias file
if [ -f ~/.env/.bashrc.custom ]; then
    . ~/.env/.bashrc.custom
fi

# Execute powerline
powerline-daemon -q
. /usr/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh

# Execute tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux
fi


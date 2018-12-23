#!/usr/bin/env bash

alias rebash="source ~/.bash_profile"       # Reload .bash_profile

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias path='echo $PATH | tr -s ":" "\n"'    # Pretty print the path

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

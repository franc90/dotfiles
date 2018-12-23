#!/usr/bin/env bash

export PROMPT_DIRTRIM=2     # Automatically trim long paths in the prompt (requires Bash 4.x)

bind "set completion-ignore-case on"        # Perform file completion in a case insensitive fashion
bind "set mark-symlinked-directories on"    # Immediately add a trailing slash when autocompleting symlinks to directories

#shopt -s globstar               # If set, the pattern "**" used in a pathname expansion context will match all files and zero or more directories and subdirectories.
shopt -s nocaseglob             # Case-insensitive globbing (used in pathname expansion)
shopt -s checkwinsize           # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s autocd 2> /dev/null    # Prepend cd to directory names automatically
shopt -s dirspell 2> /dev/null  # Correct spelling errors during tab-completion
shopt -s cdspell 2> /dev/null   # Correct spelling errors in arguments supplied to cd

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
  fi
fi
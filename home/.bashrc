# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# ############### Terminal ###############
# Automatically trim long paths in the prompt (requires Bash 4.x)
export PROMPT_DIRTRIM=2

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"
# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

# If set, the pattern "**" used in a pathname expansion context will match all files and zero or more directories and subdirectories.
#shopt -s globstar
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize
# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null


case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    }
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
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

# ############### Bash history ###############
# Append to the history file - don't overwrite it
shopt -s histappend
# Save multi-line commands as one command
shopt -s cmdhist
# Avoid duplicate entries
export HISTCONTROL="erasedups:ignoreboth"
export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTTIMEFORMAT="[%F %T] "

# ############### jenv ###############
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# ############### nnn ##################

# Change prompt to know I'm in shell of nnn's
[ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"
export NNN_COLORS='1234'
export NNN_BMS='d:~/Downloads/'
export NNN_SSHFS_OPTS="sshfs -o follow_symlinks"
export NNN_DE_FILE_MANAGER=nautilus

# ############### Others ###############
# How display man
export MANPAGER="less -FiRswX"
export EDITOR='vim'

export XDG_CONFIG_HOME="$HOME/.config"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

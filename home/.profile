# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

export CARGO_HOME=$HOME/.cargo
[ -d "$CARGO_HOME/bin" ] && PATH="$PATH:$CARGO_HOME/bin"

export NODEJS_HOME=/usr/local/lib/nodejs
if [ ! -d "$NODEJS_HOME/bin" ]; then
    echo "WARN: $NODEJS_HOME/bin not found. Create symlink to current node's bin."
else
    export PATH=$NODEJS_HOME/bin:$PATH
fi

changeWallpaper

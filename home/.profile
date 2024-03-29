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

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

export CARGO_HOME=$XDG_CONFIG_HOME/cargo
export RUSTUP_HOME=$XDG_CONFIG_HOME/rustup
[ -d "$CARGO_HOME/bin" ] && PATH="$PATH:$CARGO_HOME/bin"

export NODEJS_HOME=/opt/node
if [ ! -d "$NODEJS_HOME/bin" ]; then
    echo "WARN: $NODEJS_HOME/bin not found. Create symlink to current node's bin."
else
    export PATH=$NODEJS_HOME/bin:$PATH
fi

export GRADLE_HOME=/opt/gradle/current
if [ ! -d "$GRADLE_HOME/bin" ]; then
    echo "WARN: $GRADLE_HOME/bin not found. Create symlink to current gradle's bin."
else
    export PATH=$GRADLE_HOME/bin:$PATH
fi

export WALLPAPER=$HOME/.local/share/bg
changeWallpaper

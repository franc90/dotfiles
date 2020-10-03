SHELL = /bin/bash
DOTFILES_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(DOTFILES_DIR)/bin:$(PATH)
export XDG_CONFIG_HOME := $(HOME)/.config
export STOW_DIR := $(DOTFILES_DIR)

.PHONY: install

install: install-dotfiles
	@cat post_install

install-dotfiles: install-apps setup-desktop
	@log.sh "Installing dotfiles:"
	@mkdir -p ~/bin
	@mkdir -p ~/.local/share/bash-completion/completions
	create-links.sh home
	create-links.sh fonts /usr/local/share/fonts true && fc-cache -fv

setup-desktop:
	@log.sh "Setting up desktop:"
	sudo apt -y install i3 xorg suckless-tools lightdm

install-apps: update-system
	@log.sh "Installing apps:"
	is-executable.sh stow || sudo apt -y install stow
	sudo apt -y install vim jq curl ffmpeg git maven tree shellcheck qbittorrent htop tmux xclip nmap flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	@github-install.sh ytdl-org youtube-dl
	@install.sh ./lib/fzf

update-system:
	@log.sh "Updating system:"
	sudo apt update
	sudo apt upgrade -y
	sudo apt dist-upgrade -f

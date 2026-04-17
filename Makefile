SHELL = /bin/bash
DOTFILES_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(DOTFILES_DIR)/makefile_scripts:$(PATH)
export XDG_CONFIG_HOME := $(HOME)/.config
export STOW_DIR := $(DOTFILES_DIR)
DNF_PACKAGES := stow exfatprogs unrar curl vim-enhanced htop tmux git nmap jq \
	ffmpeg maven tree ShellCheck mpv qbittorrent xclip firewall-config \
	flameshot filezilla yt-dlp gimp

.PHONY: install

install: install-apps
	@log.sh "Installing dotfiles:"
	@mkdir -p ~/.local/bin
	@mkdir -p ~/.local/share/bash-completion/completions
	create-links.sh home
	create-links.sh fonts /usr/local/share/fonts true && fc-cache -fv
	create-links.sh bin /usr/local/bin true
	@cat post_install

install-apps: update-system
	@log.sh "Installing apps:"
	sudo dnf install -y $(DNF_PACKAGES)

update-system:
	@log.sh "Updating system:"
	sudo dnf upgrade --refresh -y

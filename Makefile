SHELL = /bin/bash
DOTFILES_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(DOTFILES_DIR)/makefile_scripts:$(PATH)
export XDG_CONFIG_HOME := $(HOME)/.config
export STOW_DIR := $(DOTFILES_DIR)

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
	is-executable.sh stow || sudo apt -y install stow
	sudo apt -y install exfatprogs unrar curl vim htop tmux git nmap jq ffmpeg maven tree \
	  shellcheck mpv qnapi qbittorrent xclip gufw newsboat flameshot python-is-python3 filezilla
	@github-install.sh yt-dlp yt-dlp

update-system:
	@log.sh "Updating system:"
	sudo apt update
	sudo apt upgrade -y
	sudo apt dist-upgrade -f
	sudo snap refresh

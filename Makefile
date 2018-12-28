SHELL = /bin/bash
DOTFILES_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(DOTFILES_DIR)/bin:$(PATH)
export XDG_CONFIG_HOME := $(HOME)/.config
export STOW_DIR := $(DOTFILES_DIR)

.PHONY: install install-i3

install: install-dotfiles
	@cat post_install

install-dotfiles: install-apps
	@echo "install-dotfiles"
	@mkdir -p ~/bin
	create-links.sh bash
	create-links.sh scripts
	create-links.sh common

install-apps: update-system
	@echo "install-apps"
	is-executable stow || sudo apt-get -y install stow
	sudo apt -y install vim jq curl ffmpeg youtube-dl git maven tree openvpn shellcheck qbittorrent
	@[[ -d ~/.jenv ]] || git clone https://github.com/gcuisinier/jenv.git ~/.jenv

install-i3: update-system
	@echo "install-i3"
	create-links.sh i3
	create-links.sh dunst
	create-links.sh compton

update-system:
	@echo "update system"
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -f

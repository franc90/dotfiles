SHELL = /bin/bash
DOTFILES_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(DOTFILES_DIR)/bin:$(PATH)
export XDG_CONFIG_HOME := $(HOME)/.config
export STOW_DIR := $(DOTFILES_DIR)

.PHONY: install

install: install-dotfiles
	@cat post_install

install-dotfiles: install-apps
	@log.sh "Installing dotfiles:"
	@mkdir -p ~/bin
	@mkdir -p ~/.local/share/bash-completion/completions
	create-links.sh home
	create-links.sh fonts /usr/local/share/fonts true && fc-cache -f -v

install-apps: update-system
	@log.sh "Installing apps:"
	is-executable.sh stow || sudo apt-get -y install stow
	sudo apt -y install vim jq curl ffmpeg git maven tree openvpn shellcheck qbittorrent htop tmux xclip nmap
	@[[ -d ~/.jenv ]] || git clone https://github.com/gcuisinier/jenv.git ~/.jenv
	@github-install.sh ytdl-org youtube-dl

update-system:
	@log.sh "Updating system:"
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -f

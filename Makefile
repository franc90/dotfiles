SHELL = /bin/bash
DOTFILES_DIR := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
PATH := $(DOTFILES_DIR)/makefile_scripts:$(PATH)
export XDG_CONFIG_HOME := $(HOME)/.config
export STOW_DIR := $(DOTFILES_DIR)
DNF_PACKAGES := stow exfatprogs unrar curl vim-enhanced htop tmux git nmap jq \
	maven tree ShellCheck mpv qbittorrent xclip firewall-config \
	flameshot yt-dlp bat nnn fzf prettyping alacritty filezilla \
	flatpak gimp perl-Image-ExifTool

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
	if rpm -q ffmpeg-free >/dev/null 2>&1; then \
		sudo dnf swap -y --allowerasing ffmpeg-free ffmpeg; \
	else \
		sudo dnf install -y ffmpeg; \
	fi
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
	flatpak install -y flathub md.obsidian.Obsidian

update-system:
	@log.sh "Updating system:"
	sudo dnf upgrade --refresh -y

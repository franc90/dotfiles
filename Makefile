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
	sudo apt -y install i3 xorg sddm

install-apps: update-system
	@log.sh "Installing apps:"
	is-executable.sh stow || sudo apt -y install stow
	sudo apt -y install firmware-linux firmware-linux-nonfree intel-microcode dosfstools exfat-utils ntfs-3g unrar udiskie \
		libnotify-bin network-manager network-manager-gnome curl vim htop tmux git nmap jq ffmpeg maven tree xwallpaper xbacklight \
		shellcheck vlc pulseaudio pulsemixer pavucontrol qnapi sxiv arandr qbittorrent xclip
	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	sudo flatpak install -y flathub org.mozilla.firefox org.gimp.GIMP org.telegram
	@github-install.sh ytdl-org youtube-dl
	@install.sh ./lib/fzf

update-system:
	@log.sh "Updating system:"
	sudo apt update
	sudo apt upgrade -y
	sudo apt dist-upgrade -f
	is-executable.sh flatpak || sudo apt install -y flatpak
	sudo flatpak update

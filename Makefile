current_dir = $(shell pwd)
srcs = $(wildcard bin/*)
bins = $(srcs:bin/%.sh=%)
home_bin = ~/bin
vim_conf = vimrc vimrc_background
home_conf = $(vim_conf) Xresources

.PHONY: all prepare install_local_bins install_home_config

all: prepare install_local_bins install_home_config

prepare:
	@chmod +x _install/*

install_local_bins: $(bins)
	@./_install/chmod.sh ${current_dir}/bin

$(bins):
	@echo "Installing bin: "$@
	@mkdir -p ~/bin
	@./_install/mk_link.sh bin/$@.sh bin/$@

install_home_config: $(home_conf)

$(home_conf): ~/.$@
	@echo "Installing "$@
	@./_install/mk_link.sh $@ .$@
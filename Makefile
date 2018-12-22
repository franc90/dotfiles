current_dir = $(shell pwd)
bins_target = ~/bin
vim_conf = vimrc vimrc_background
xresources_conf = Xresources
all_conf = $(vim_conf) $(xresources_conf)

.PHONY: all install_bins install_home_config

all: install_bins install_home_config

install_bins:
	@echo "Installing bins"
	@chmod +x ${current_dir}/bin/*
	@rm -rf ${bins_target}
	@ln -s ${current_dir}/bin ${bins_target}

install_home_config: $(all_conf)

$(all_conf): ~/.$@
	@echo "Installing "$@
	@([ -L ~/.$@ ] && [ -e ~/.$@ ]) || (rm -f ~/.$@ && ln -s ${current_dir}/$@ ~/.$@)
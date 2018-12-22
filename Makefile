current_dir = $(shell pwd)
target = ~/bin

.PHONY: all install_bins

all: install_bins

install_bins:
	chmod +x ${current_dir}/bin/*
	rm -rf ${target}
	ln -s ${current_dir}/bin ${target}

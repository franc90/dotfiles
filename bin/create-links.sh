#!/usr/bin/env bash

readonly directory=$1

mkdir -p ${XDG_CONFIG_HOME}

for FILE in $(ls -A ${directory}); do
    if  [[ -f "${directory}/${FILE}" \
        && -f ${HOME}/${FILE} \
        && ! -h ${HOME}/${FILE} ]]; then
        mv -v ${HOME}/${FILE}{,.bak};
    fi
done

stow -t ${HOME} ${directory}
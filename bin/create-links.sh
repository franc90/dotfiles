#!/usr/bin/env bash

readonly SOURCE_DIR="$1"
readonly TARGET_DIR="${2:-"$HOME"}"
readonly SHOULD_SUDO="${3:-""}"

[[ -d "${XDG_CONFIG_HOME}" ]] || mkdir -p "${XDG_CONFIG_HOME}"

for FILE in $(ls -A "${SOURCE_DIR}"); do
    if  [[ -f ${SOURCE_DIR}/${FILE} \
        && -f ${TARGET_DIR}/${FILE} \
        && ! -h ${TARGET_DIR}/${FILE} ]]; then
            echo "creating '$FILE' backup"
        mv -v ${TARGET_DIR}/${FILE}{,.bak}
    fi
done

CMD="stow -t ${TARGET_DIR} ${SOURCE_DIR}"
if [[ ! -z "$SHOULD_SUDO" ]]; then
    $(sudo $CMD)
else
    $($CMD)
fi

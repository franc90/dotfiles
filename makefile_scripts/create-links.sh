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

for DIR in $(find "$SOURCE_DIR" -type d | tail -n +2 | sed "s|$SOURCE_DIR/|$TARGET_DIR/|"); do
    if [[ -n "$SHOULD_SUDO" ]]; then
        sudo mkdir -p "$DIR"
    else
        mkdir -p "$DIR"
    fi
done

CMD="stow -t ${TARGET_DIR} ${SOURCE_DIR}"
if [[ -n "$SHOULD_SUDO" ]]; then
    $(sudo $CMD)
else
    $($CMD)
fi

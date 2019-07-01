# source files in dots

readonly BASH_DIR=$(dirname $(readlink -f ~/.bash_profile))
readonly DOTS=${BASH_DIR}/dots

for file in $(ls -A ${DOTS}); do
    FILE_PATH=${DOTS}/${file}
    [[ -r "$FILE_PATH" ]] && [[ -f "$FILE_PATH" ]] && source "$FILE_PATH";
done;

unset file;

export PATH="$HOME/.cargo/bin:$PATH"

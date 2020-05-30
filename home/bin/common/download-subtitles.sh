#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

FILENAME=$(basename "$0")

if [[ "$FILENAME" == "plsub" ]]; then
  LANG="pl"
elif [[ "$FILENAME" == "ensub" ]]; then
  LANG="en"
else
  echo "Downloading default subtitles (english)"
  LANG="en"
fi

FILES=$(
  find . -maxdepth 1 -type f | # find files in curr dir
    sed 's|^\.\/||' | # remove './' from beginning
    sort |
    fzf -m --phony --no-sort --cycle --layout=reverse --preview='bat --style=numbers --color=always {} | head -500'
)

SAVEIFS=$IFS   # Save current IFS
IFS=$'\n'      # Change IFS to new line
FILES=($FILES) # split to array $FILES
IFS=$SAVEIFS   # Restore IFS

for (( i=0; i<${#FILES[@]}; i++ )); do
  qnapi -c -l "$LANG" "${FILES[$i]}"
done

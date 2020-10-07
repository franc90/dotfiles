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

ORIG_IFS=$IFS
IFS=$'\n'
FILES=($FILES) # split to array
IFS=$ORIG_IFS

for FILE in "${FILES[@]}"; do
  qnapi -c -l "$LANG" "$FILE"
done

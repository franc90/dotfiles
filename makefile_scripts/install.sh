#!/usr/bin/env bash

readonly RED='\033[0;31m'
readonly RESET='\033[0m'
readonly ARTIFACT_PATH="$1"
[ -z "$ARTIFACT_PATH" ] && { echo -e "${RED}Path to artifact is required.$RESET" ; exit 1; }
[ ! -f "$ARTIFACT_PATH" ] && echo -e "${RED}No artifact at path $ARTIFACT_PATH$RESET" && exit 1

readonly ARTIFACT_NAME="$(basename "$ARTIFACT_PATH")"
readonly TARGET_PATH="/usr/local/bin/$ARTIFACT_NAME"
readonly NEW_VERSION="$(./"$ARTIFACT_PATH" --version)"

if [ -f "$TARGET_PATH" ]; then
  readonly OLD_VERSION="$("$TARGET_PATH" --version)"
else
  readonly OLD_VERSION="0"
fi


if [[ "$NEW_VERSION" > "$OLD_VERSION" ]]; then
  echo "Installing $ARTIFACT_NAME $NEW_VERSION over $OLD_VERSION."
  [ -f "$TARGET_PATH" ] && sudo rm "$TARGET_PATH"
  sudo cp "$ARTIFACT_PATH" "$TARGET_PATH"
else
  echo "$ARTIFACT_NAME already at the newest version."
fi
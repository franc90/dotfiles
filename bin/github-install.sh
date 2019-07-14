#!/usr/bin/env bash

readonly RED='\033[0;31m'
readonly RESET='\033[0m'
readonly GITHUB_USER="$1"
readonly GITHUB_REPO="$2"
readonly ARTIFACT="${3:-"$GITHUB_REPO"}"
# if version != latest needs to be release id from https://api.github.com/repos/$GITHUB_USER/$GITHUB_REPO/releases
# TODO add searching tag_name -> id so that it would be more user friendly
readonly VERSION="${4:-"latest"}"
readonly TARGET_DIR="${5:-"/usr/local/bin/"}"
readonly ARTIFACT_PATH="$TARGET_DIR$ARTIFACT"
readonly RELEASE_INFO=$(curl --silent "https://api.github.com/repos/$GITHUB_USER/$GITHUB_REPO/releases/$VERSION" )

if [ "$(echo "$RELEASE_INFO" | jq -r '.assets | length')" == "0" ]; then
  echo -e "${RED}No assets found for $ARTIFACT $VERSION$RESET"
  exit 1
fi

DOWNLOAD_APP=true
mkdir -p "$TARGET_DIR"

if hash "$ARTIFACT" 2>/dev/null; then
  readonly CURRENT_VERSION=$($ARTIFACT --version)
  readonly WANTED_VERSION=$(echo "$RELEASE_INFO" | jq -r '.tag_name')
  if [ "$CURRENT_VERSION" != "$WANTED_VERSION" ]; then
    echo "Updating $ARTIFACT $CURRENT_VERSION -> $WANTED_VERSION."
    sudo rm "$ARTIFACT_PATH"
  else
    echo "$ARTIFACT $VERSION already installed."
    DOWNLOAD_APP=false
  fi
else
  echo "$ARTIFACT doesn't exists, will be downloaded."
fi

if [ "$(echo "$RELEASE_INFO" | jq -r --arg ARTIFACT "$ARTIFACT" '
      [.assets[] | select(.name == $ARTIFACT) ] | flatten | length')" == "0" ]; then
  echo -e "${RED}Aborting - no asset named '$ARTIFACT' found for $ARTIFACT $VERSION.$RESET"
  exit 1
fi

if $DOWNLOAD_APP; then
  readonly APP_URL=$(echo "$RELEASE_INFO" |
    jq -r --arg ARTIFACT "$ARTIFACT" '
        .assets[] |
        select(.name == $ARTIFACT) |
        .browser_download_url'
        )
  echo "Downloading $APP_URL"
  sudo wget -q --directory-prefix="$TARGET_DIR" "$APP_URL"
  echo "... downloaded"
  sudo chmod +x "$ARTIFACT_PATH"
fi

#!/usr/bin/env bash

readonly GITHUB_USER="$1"
readonly GITHUB_REPO="$2"
readonly ARTIFACT="${2:-"$GITHUB_REPO"}"
readonly TARGET_DIR="${3:-"/usr/local/bin/"}"
readonly ARTIFACT_PATH="$TARGET_DIR$ARTIFACT"
readonly LATEST_RELEASE_INFO=$(curl --silent "https://api.github.com/repos/$GITHUB_USER/$GITHUB_REPO/releases/latest" )
DOWNLOAD_NEW=true

mkdir -p "$TARGET_DIR"

if hash youtube-dl 2>/dev/null; then
  readonly CURRENT_VERSION=$(youtube-dl --version)
  readonly LATEST_VERSION=$(echo "$LATEST_RELEASE_INFO" | jq -r '.tag_name')
  if [[ "$CURRENT_VERSION" < "$LATEST_VERSION" ]]; then
    echo "updating $ARTIFACT $CURRENT_VERSION -> $LATEST_VERSION"
    sudo rm "$ARTIFACT_PATH"
  else
    echo "Latest version of $ARTIFACT installed."
    DOWNLOAD_NEW=false
  fi
else
  echo "doesn't exists, will download"
fi

if $DOWNLOAD_NEW; then
  readonly APP_URL=$(echo "$LATEST_RELEASE_INFO" |
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

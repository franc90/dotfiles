#!/usr/bin/env bash

set -euo pipefail

readonly KEYBINDINGS_SCHEMA="org.gnome.settings-daemon.plugins.media-keys"
readonly ALACRITTY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/alacritty/"
readonly FIREFOX_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/firefox/"
readonly FILES_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/"

if ! command -v gsettings >/dev/null 2>&1; then
  echo "Skipping GNOME shortcut configuration: gsettings not found."
  exit 0
fi

if [[ -z "${DBUS_SESSION_BUS_ADDRESS:-}" ]]; then
  echo "Skipping GNOME shortcut configuration: no session bus available."
  exit 0
fi

current_bindings="$(gsettings get "$KEYBINDINGS_SCHEMA" custom-keybindings)"

add_binding_path() {
  local current="$1"
  local path="$2"

  if [[ "$current" == "@as []" || "$current" == "[]" ]]; then
    printf "['%s']" "$path"
  elif [[ "$current" == *"'$path'"* ]]; then
    printf "%s" "$current"
  else
    current="${current%]}"
    printf "%s, '%s']" "$current" "$path"
  fi
}

set_binding() {
  local path="$1"
  local name="$2"
  local command="$3"
  local binding="$4"
  local schema_path="${KEYBINDINGS_SCHEMA}.custom-keybinding:${path}"

  gsettings set "$schema_path" name "$name"
  gsettings set "$schema_path" command "$command"
  gsettings set "$schema_path" binding "$binding"
}

updated_bindings="$(add_binding_path "$current_bindings" "$ALACRITTY_PATH")"
updated_bindings="$(add_binding_path "$updated_bindings" "$FIREFOX_PATH")"
updated_bindings="$(add_binding_path "$updated_bindings" "$FILES_PATH")"
gsettings set "$KEYBINDINGS_SCHEMA" custom-keybindings "$updated_bindings"

set_binding "$ALACRITTY_PATH" "Alacritty" "alacritty" "<Super>Return"
set_binding "$FIREFOX_PATH" "Firefox" "firefox" "<Super>b"
set_binding "$FILES_PATH" "Files" "nautilus --new-window \"$HOME\"" "<Super>f"

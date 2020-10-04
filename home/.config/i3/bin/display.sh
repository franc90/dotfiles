#!/bin/bash
# This script is intended to make switching between laptop and external displays easier when using i3+dmenu
# To run this script, map it to some shortcut in your i3 config, e.g:
# bindsym $mod+p exec --no-startup-id $config/display.sh
# IMPORTANT: run chmod +x on the script to make it executable
# The result is 4 options appearing in dmenu, from which you can choose

INTERNAL_OUTPUT="eDP-1"
EXTERNAL_OUTPUT="$(xrandr | grep ' connected' | grep -v 'eDP-1' | awk '{print $1}')"

choices="laptop\ndual\nexternal\nclone"
chosen=$(echo -e $choices | dmenu -i)

case "$chosen" in
    external)
      xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto --primary
      ;;
    laptop)
      xrandr --output $INTERNAL_OUTPUT --auto --primary --output $EXTERNAL_OUTPUT --off
      ;;
    clone)
      xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --same-as $INTERNAL_OUTPUT
      ;;
    dual)
      xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --auto --right-of $INTERNAL_OUTPUT --primary
      ;;
esac
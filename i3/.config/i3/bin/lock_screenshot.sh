#!/bin/bash

# Take a screenshot:
scrot /tmp/screen.png

# Create a blur on the shot:
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png

# Add the lock to the blurred image:
# [[ -f ~/.config/i3/lock.png ]] && convert /tmp/screen.png  ~/.config/i3/lock.png -gravity center -composite -matte /tmp/screen.png


ICON=$HOME/.config/i3/lock.png

if [[ -f $ICON ]]
then
    # placement x/y
    PX=0
    PY=0
    # lockscreen image info
    R=$(file $ICON | grep -o '[0-9]* x [0-9]*')
    RX=$(echo $R | cut -d' ' -f 1)
    RY=$(echo $R | cut -d' ' -f 3)
 
    SR=$(xrandr --query | grep ' connected' | sed 's/primary //' | cut -f3 -d' ')
    for RES in $SR
    do
        # monitor position/offset
        SRX=$(echo $RES | cut -d'x' -f 1)                   # x pos
        SRY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 1)  # y pos
        SROX=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 2) # x offset
        SROY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 3) # y offset
        PX=$(($SROX + $SRX/2 - $RX/2))
        PY=$(($SROY + $SRY/2 - $RY/2))
 
        convert /tmp/screen.png $ICON -geometry +$PX+$PY -composite -matte  /tmp/screen.png
        echo "done"
    done
fi

# Lock it up!
i3lock -e -f -c 000000 -i /tmp/screen.png

# If still locked after 20 seconds, turn off screen.
sleep 20 && pgrep i3lock && xset dpms force off

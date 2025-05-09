#!/bin/bash

pamixer -t
if pamixer --get-mute | grep -q "true"; then
    icon="volume-mute.svg"
    msg="Muted"
else
    icon="volume.svg"
    msg="Unmuted"
fi
dunstify -i ~/.config/dunst/assets/$icon -t 500 -r 2593 "$msg"

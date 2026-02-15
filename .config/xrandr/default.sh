#!/bin/sh
# Auto-detect external display (non-eDP)
EXTERNAL=$(xrandr --query | grep -E "^[^ ]+ connected" | grep -v "eDP" | head -1 | cut -d' ' -f1)

if [ -z "$EXTERNAL" ]; then
    notify-send -t 2000 "No external display detected" -u low
    source $HOME/.config/xrandr/default.sh
else
    notify-send -t 2000 "Display: Default (eDP only)" -u low
    xrandr --output eDP --primary --mode 2256x1504 --pos 0x0 --rotate normal --output "$EXTERNAL" --off
    nitrogen --restore
fi

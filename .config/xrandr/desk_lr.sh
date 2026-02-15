#!/bin/sh
# Auto-detect external display (non-eDP)
EXTERNAL=$(xrandr --query | grep -E "^[^ ]+ connected" | grep -v "eDP" | head -1 | cut -d' ' -f1)

if [ -z "$EXTERNAL" ]; then
    echo "No external monitor detected"
    source $HOME/.config/xrandr/default.sh
else
    xrandr --output eDP --primary --mode 2256x1504 --pos 0x0 --rotate normal --output "$EXTERNAL" --mode 3840x2160 --pos 2256x0 --rotate normal
    nitrogen --restore
fi

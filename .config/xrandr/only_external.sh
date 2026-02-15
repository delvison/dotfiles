#!/bin/sh
# Auto-detect external display (non-eDP)
EXTERNAL=$(xrandr --query | grep -E "^[^ ]+ connected" | grep -v "eDP" | head -1 | cut -d' ' -f1)

if [ -z "$EXTERNAL" ]; then
    echo "No external monitor detected"
    source $HOME/.config/xrandr/default.sh
else
    xrandr --output eDP --off --output "$EXTERNAL" --primary --mode 3840x2160 --pos 0x0 --rotate normal
    nitrogen --restore
fi

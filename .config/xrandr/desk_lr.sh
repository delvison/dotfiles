#!/bin/sh
if [ $(xrandr --listmonitors | grep -c "Monitors: 1") -eq 1 ]; then
    echo "Only one monitor detected"
    source $HOME/.config/xrandr/default.sh
else
  xrandr --output eDP --primary --mode 2256x1504 --pos 0x0 --rotate normal --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --off --output DisplayPort-3 --off --output DisplayPort-4 --off --output DisplayPort-5 --off --output DisplayPort-6 --off --output DisplayPort-7 --off --output DisplayPort-8 --off --output DisplayPort-9 --mode 3840x2160 --pos 2256x0 --rotate normal --output DisplayPort-10 --off
  nitrogen --restore
fi

#!/usr/bin/env bash

action="${1}"
monitor_count=$(hyprctl monitors all | grep -c Monitor)

if [ "${action}" == "close" ] && [ "${monitor_count}" == 1 ]; then
    swaylock -f &
    aplay ~/.config/hypr/assets/pop2.wav
    sleep 5
    systemctl suspend
elif [ "${action}" == "close" ] && [ "${monitor_count}" -gt 1 ]; then
    hyprctl keyword monitor "eDP-1,disable"
elif [ "${action}" == "open" ] && [ "${monitor_count}" -gt 1 ]; then
    hyprctl keyword monitor "eDP-1,highres,auto,1.175"
fi

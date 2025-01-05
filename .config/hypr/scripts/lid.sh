#!/usr/bin/env bash

action="${1}"
monitor_count=$(hyprctl monitors all | grep -c Monitor)

# if lid closes with no monitors connected
if [ "${action}" == "close" ] && [ "${monitor_count}" == 1 ]; then
    # swaylock -f &
    hyprlock &
    aplay ~/.config/hypr/assets/pop2.wav
    sleep 5
    systemctl suspend
elif [ "${action}" == "close" ] && [ "${monitor_count}" -gt 1 ]; then
    hyprctl keyword monitor "eDP-1,disable"
    notify-send -t 5000 "Monitor" "eDP-1 has been disabled" -u low -r 9001
elif [ "${action}" == "open" ] && [ "${monitor_count}" -gt 1 ]; then
    hyprctl keyword monitor "eDP-1,highres,auto,1.175"
    notify-send -t 5000 "Monitor" "eDP-1 has been enabled" -u low -r 9001
fi

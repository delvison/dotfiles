#!/usr/bin/env bash
if [ "$1" == "close" ]; then
  if [ "$(hyprctl monitors all | grep Monitor | wc -l)" == 1 ]; then
    systemctl suspend
  else
    hyprctl keyword monitor "eDP-1,disable"
  fi
elif [ "$1" == "open" ] && [ "$(hyprctl monitors all | grep Monitor | wc -l)" == 1 ]; then
  swaylock
else
  hyprctl keyword monitor "eDP-1,highres,auto,1.175"
fi

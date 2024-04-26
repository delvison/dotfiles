#!/usr/bin/env bash

if [ "$1" == "up" ]; then
  brightnessctl set 5%+
else
  brightnessctl set 5%-
fi

notify-send -t 1000 "Brightness" "$(brightnessctl get)\%" -u low -r 9000

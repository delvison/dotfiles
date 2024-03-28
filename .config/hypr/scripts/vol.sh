#!/usr/bin/env bash

aplay ~/.config/hypr/assets/pop2.wav
if [ "$1" == "up" ]; then
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
else
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
fi

vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
vol_p=$(echo "${vol} * 100" | bc)

notify-send -t 1000 "󰕾 Volume" "${vol_p}" -u low -r 9001


#!/usr/bin/env bash

aplay ~/.config/hypr/assets/pop2.wav
if [ -f "/tmp/.nightlight" ]; then
  kill $(pgrep wlsunset)
  rm /tmp/.nightlight
  notify-send -t 1000 "Nightlight" "off" -u low -r 9000
else
  touch /tmp/.nightlight
  wlsunset -T 6500 &
  notify-send -t 1000 "Nightlight" "on" -u low -r 9000
fi

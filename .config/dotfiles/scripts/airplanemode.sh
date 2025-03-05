#!/usr/bin/env bash

# aplay ~/.config/hypr/assets/pop2.wav
if [ -f "/tmp/.airplanemode" ]; then
  nmcli r all on
  rm -f /tmp/.airplanemode
  notify-send -t 1000 "Airplane mode" "off" -u low -r 9000
else
  touch /tmp/.airplanemode
  nmcli r all off
  notify-send -t 1000 "Airplane mode" "on" -u low -r 9000
fi

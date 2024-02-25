#!/usr/bin/env bash

aplay ~/.config/hypr/assets/pop2.wav
if [ -f "/tmp/.nightlight" ]; then
  kill $(pgrep wlsunset)
  rm /tmp/.nightlight
else
  touch /tmp/.nightlight
   wlsunset -T 6500 &
fi

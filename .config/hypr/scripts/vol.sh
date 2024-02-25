#!/usr/bin/env bash

aplay ~/.config/hypr/assets/pop2.wav
if [ "$1" == "up" ]; then
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
else
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
fi

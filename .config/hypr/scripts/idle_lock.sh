#!/usr/bin/env bash

f_override="/tmp/.nosleep"

if [ ! -f "${f_override}" ]; then
  # swaylock -f
  hyprlock
  sleep 30
  hyprctl dispatch dpms off
else
  notify-send -t 3000 "Idling disabled" "Please remove ${f_override} to enable idling."  -u low
fi

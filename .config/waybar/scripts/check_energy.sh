#!/usr/bin/env bash

watt=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep "energy-rate" | awk '{print $2}')

echo "{\"text\":\" ${watt}w \"}"

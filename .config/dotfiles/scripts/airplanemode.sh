#!/usr/bin/env bash

# Check the current status of all network interfaces
if nmcli radio all | grep -q 'enabled'; then
  nmcli radio all off  # Disable all network interfaces
  notify-send -t 1000 "Airplane mode" "turned on" -u low -r 9000  # Notify the user
else
  nmcli radio all on  # Enable all network interfaces
  notify-send -t 1000 "Airplane mode" "turned off" -u low -r 9000  # Notify the user
fi


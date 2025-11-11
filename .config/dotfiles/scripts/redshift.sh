#!/usr/bin/env bash

is_redshift_running() {
    pgrep -f "redshift-gtk" >/dev/null
}

if ! is_redshift_running; then
  coordinates=$(curl -s "https://ip-api.com/json" | jq -r '(.lat | tostring) + ":" + (.lon | tostring)')

  if [ -n "$coordinates" ]; then
      echo "$coordinates" > $HOME/.cache/coordinates
  fi

  redshift-gtk -l $(cat $HOME/.cache/coordinates)
fi

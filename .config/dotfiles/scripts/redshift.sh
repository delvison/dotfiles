#!/usr/bin/env bash

coordinates=$(curl -s "http://ip-api.com/json" | jq -r '(.lat | tostring) + ":" + (.lon | tostring)')

if [ -n "$coordinates" ]; then
    echo "$coordinates" > ~/.cache/coordinates
fi

redshift-gtk -l $(cat ~/.cache/coordinates)

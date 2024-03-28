#!/usr/bin/env bash

route -n | grep -q -E '^0.0.0.0.*tun.*$' \
&& echo '{"text":"Connected","class":"connected","percentage":100}' \
|| echo '{"text":"Disconnected","class":"disconnected","percentage":0}'

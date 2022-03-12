#!/bin/bash

if [[ $(kdeconnect-cli -l) =~ "paired" ]]; then
  notify-send "Device Paired and Reachable" -t 5000
else
  notify-send "Device not reachable" -t 5000
fi


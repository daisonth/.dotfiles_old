#!/usr/bin/env bash 

pamixer -t ;
if [[ $(pamixer --get-volume-human) == "muted" ]]; then
  notify-send "Muted <X" -t 700
else
  notify-send "Unmuted <=" -t 700
fi

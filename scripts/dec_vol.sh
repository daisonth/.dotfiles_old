#!/bin/bash

pamixer --allow-boost -d 5 ; notify-send "vol : $(pamixer --get-volume-human) -" -t 700

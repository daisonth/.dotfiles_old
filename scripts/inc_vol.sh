#!/bin/bash

pamixer --allow-boost -i 5 ; notify-send "vol : $(pamixer --get-volume-human) +" -t 700

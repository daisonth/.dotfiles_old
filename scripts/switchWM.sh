#!/bin/bash

str=$'HerbstluftWM\nDWM'
read p <<< $(echo "$str"|dmenu)

if [ $str == "HerbstluftWM" ];then
  cd
  st youtube-dl --restrict-filenames $(xsel)
  notify-send "Youtube video downloaded" -t 5000

#!/bin/bash

if [[ $(xsel) =~ "youtu" ]]; then
  str=$'Video\nAudio'
  read p <<< $(echo "$str"|dmenu) 
  x=$(xsel)

  if [ $p == "Video" ];then
      youtube-dl --restrict-filenames $(xsel -op)
      notify-send "Youtube video downloaded" -t 5000
  elif [ $p == "Audio" ]; then
      youtube-dl -x --audio-format mp3 $(xsel -op)
      notify-send "Youtube audio downloaded" -t 5000
  else
      exit
  fi
else 
  notify-send "No YouTube URL found!" -t 3000
fi

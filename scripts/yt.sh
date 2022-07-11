#!/bin/bash

if [[ $(xsel) =~ "youtube" ]]; then
  str=$'Video\nAudio'
  read p <<< $(echo "$str"|dmenu) 

  if [ $p == "Video" ];then
      cd $HOME/videos
      alacritty -e youtube-dl --restrict-filenames $(xsel)
      notify-send "Youtube video downloaded" -t 5000
  elif [ $p == "Audio" ]; then
      cd $HOME/audio
      alacritty -e youtube-dl -x --audio-format mp3 $(xsel)
      notify-send "Youtube audio downloaded" -t 5000

  else
      exit
  fi
else 
  notify-send "No YouTube URL found!" -t 3000
fi

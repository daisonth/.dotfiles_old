#!/bin/bash

str=$'Videos\nYouTube\nRead-Clipboard'
read p <<< $(echo "$str"|dmenu)

if [ $p == "YouTube" ]
then
   str=$'Play\nDownload-video\nDownload-audio'
   read p <<< $(echo "$str"|dmenu)
   if [ $p == "Download-video" ]
   then
      cd $HOME/videos
      st youtube-dl --restrict-filenames $(xsel)
   elif [ $p == "Download-audio" ]
   then
      cd $HOME/audio
      st youtube-dl -x --audio-format mp3 $(xsel)
   elif [ $p == "Play" ]
   then
      xsel | xargs mpv
   else
      bash $HOME/scripts/themenu.sh
   fi
      
elif [ $p == "Videos" ]
then
   cd $HOME/videos
   read p <<< $(ls|dmenu)
   mpv $p
elif [ ${p:0:1} == ":" ]
then
   echo ${p:1} | xsel
   st -e bash $home/scripts/cheat.sh
elif [ $p == "run" ]
then
   read p <<< $(echo|dmenu)
   echo $p | xsel
   st -e bash $HOME/scripts/run.sh
elif [ $p == "Read-Clipboard" ]
then
   echo $(xsel) > $HOME/mimic/testfile
   st -e bash $HOME/scripts/mimi.sh
else
   exit
fi

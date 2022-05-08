#!/bin/bash

str=$'alacritty\nspectrwm\nHerbstluftwm\nnvim\ndmenu\nst\nranger\nzathurarc\n.stow-local-ignore\n.dunstrc\n.xinitrc\n.bashrc\n.fehbg\n.conkyrc\nscripts\nqutebrowser'
read p <<< $(echo "$str"|dmenu)

if [ $p == "alacritty" ];then
  cd /home/daison/.dotfiles/.config/alacritty/
  alacritty -e nvim alacritty.yml

elif [ $p == "spectrwm" ];then
  cd /home/daison/.dotfiles/.config/spectrwm/
  alacritty -e nvim spectrwm.conf

elif [ $p == "Herbstluftwm" ];then
  cd /home/daison/.dotfiles/.config/herbstluftwm/
  alacritty -e nvim autostart

elif [ $p == "nvim" ];then
  cd /home/daison/.dotfiles/.config/nvim/
  alacritty -e nvim init.lua

elif [ $p == "dmenu" ];then
  cd /home/daison/.dotfiles/dmenu/
  alacritty -e nvim config.def.h

elif [ $p == "st" ];then
  cd /home/daison/.dotfiles/st/
  alacritty -e nvim config.def.h 

elif [ $p == "ranger" ];then
  cd /home/daison/.dotfiles/.config/ranger/
  alacritty -e nvim rc.conf 

elif [ $p == "zathurarc" ];then
  cd /home/daison/.dotfiles/.config/zathura/
  alacritty -e nvim zathurarc

elif [ $p == ".dunstrc" ];then
  cd /home/daison/.dotfiles/.config/dunst/
  alacritty -e nvim dunstrc

elif [ $p == ".xinitrc" ];then
  cd /home/daison/.dotfiles/
  alacritty -e nvim .xinitrc

elif [ $p == ".bashrc" ];then
  cd /home/daison/.dotfiles/
  alacritty -e nvim .bashrc
 
elif [ $p == ".fehbg" ];then
  cd /home/daison/.dotfiles/
  alacritty -e nvim .fehbg
 
elif [ $p == ".conkyrc" ];then
  cd /home/daison
  alacritty -e nvim .conkyrc

elif [ $p == ".stow-local-ignore" ];then
  cd /home/daison/.dotfiles/
  alacritty -e nvim .stow-local-ignore
  
elif [ $p == "qutebrowser" ];then
  cd /home/daison/.dotfiles/.config/qutebrowser/
  alacritty -e nvim config.py

elif [ $p == "scripts" ];then
  cd /home/daison/.dotfiles/scripts/
  read p <<< $(ls|dmenu)
  alacritty -e nvim $p

else 
  exit 

fi

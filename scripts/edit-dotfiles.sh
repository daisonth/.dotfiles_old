#!/bin/bash

str=$'alacritty\nspectrwm\nHerbstluftwm\nnvim\ndmenu\nst\nranger\nzathurarc\n.stow-local-ignore\n.dunstrc\n.xinitrc\n.bashrc\n.fehbg\n.conkyrc\nscripts\nqutebrowser'
read p <<< $(echo "$str"|dmenu)

if [ $p == "alacritty" ];then
  cd $HOME/.dotfiles/.config/alacritty/
  notify-send "Edit alacritty config file" -t 5000
  alacritty -e nvim alacritty.yml

elif [ $p == "spectrwm" ];then
  cd $HOME/.dotfiles/.config/spectrwm/
  notify-send "Edit spectrwm config file" -t 5000
  alacritty -e nvim spectrwm.conf

elif [ $p == "Herbstluftwm" ];then
  cd $HOME/.dotfiles/.config/herbstluftwm/
  notify-send "Edit Herbstluftwm config file" -t 5000
  alacritty -e nvim autostart

elif [ $p == "nvim" ];then
  cd $HOME/.dotfiles/.config/nvim/
  notify-send "Edit nvim config file" -t 5000
  alacritty -e nvim init.lua

elif [ $p == "dmenu" ];then
  cd $HOME/.dotfiles/dmenu/
  notify-send "Edit dmenu config file" -t 5000
  alacritty -e nvim config.def.h

elif [ $p == "st" ];then
  cd $HOME/.dotfiles/st/
  notify-send "Edit alacritty config file" -t 5000
  alacritty -e nvim config.def.h 

elif [ $p == "ranger" ];then
  cd $HOME/.dotfiles/.config/ranger/
  notify-send "Edit ranger config file" -t 5000
  alacritty -e nvim rc.conf 

elif [ $p == "zathurarc" ];then
  cd $HOME/.dotfiles/.config/zathura/
  notify-send "Edit zathura config file" -t 5000
  alacritty -e nvim zathurarc

elif [ $p == ".dunstrc" ];then
  cd $HOME/.dotfiles/.config/dunst/
  notify-send "Edit dunstrc" -t 5000
  alacritty -e nvim dunstrc

elif [ $p == ".xinitrc" ];then
  cd $HOME/.dotfiles/
  notify-send "Edit .xinitrc" -t 5000
  alacritty -e nvim .xinitrc

elif [ $p == ".bashrc" ];then
  cd $HOME/.dotfiles/
  notify-send "Edit .bashrc" -t 5000
  alacritty -e nvim .bashrc
 
elif [ $p == ".fehbg" ];then
  cd $HOME/.dotfiles/
  notify-send "Edit .fehbg" -t 5000
  alacritty -e nvim .fehbg
 
elif [ $p == ".conkyrc" ];then
  cd $HOME
  notify-send "Edit .conkyrc" -t 5000
  alacritty -e nvim .conkyrc

elif [ $p == ".stow-local-ignore" ];then
  cd $HOME/.dotfiles/
  notify-send "Edit .stow-local-ignore" -t 5000
  alacritty -e nvim .stow-local-ignore
  
elif [ $p == "qutebrowser" ];then
  cd $HOME/.dotfiles/.config/qutebrowser/
  notify-send "Edit qutebrowser config file" -t 5000
  alacritty -e nvim config.py

elif [ $p == "scripts" ];then
  cd $HOME/.dotfiles/scripts/
  read p <<< $(ls|dmenu)
  notify-send "Edit $p" -t 5000
  alacritty -e nvim $p

else 
  exit 

fi

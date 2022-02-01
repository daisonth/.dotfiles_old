#!/bin/bash

str=$'Herbstluftwm\nnvim\ndmenu\nst\nranger\nzathurarc\n.stow-local-ignore\n.dunstrc\n.xinitrc\n.bashrc\n.fehbg\nscripts'
read p <<< $(echo "$str"|dmenu)

if [ $p == "Herbstluftwm" ];then
  cd $HOME/.dotfiles/.config/herbstluftwm/
  notify-send "Edit Herbstluftwm config file" -t 5000
  st -e nvim autostart

elif [ $p == "nvim" ];then
  cd $HOME/.dotfiles/.config/nvim/
  notify-send "Edit nvim config file" -t 5000
  st -e nvim init.lua

elif [ $p == "dmenu" ];then
  cd $HOME/.dotfiles/dmenu/
  notify-send "Edit dmenu config file" -t 5000
  st -e nvim config.def.h

elif [ $p == "st" ];then
  cd $HOME/.dotfiles/st/
  notify-send "Edit st config file" -t 5000
  st -e nvim config.def.h 

elif [ $p == "ranger" ];then
  cd $HOME/.dotfiles/.config/ranger/
  notify-send "Edit ranger config file" -t 5000
  st -e nvim rc.conf 

elif [ $p == "zathurarc" ];then
  cd $HOME/.dotfiles/.config/zathura/
  notify-send "Edit zathura config file" -t 5000
  st -e nvim zathurarc

elif [ $p == ".dunstrc" ];then
  cd $HOME/.dotfiles/.config/dunst/
  notify-send "Edit dunstrc" -t 5000
  st -e nvim dunstrc

elif [ $p == ".bashrc" ];then
  cd $HOME/.dotfiles/
  notify-send "Edit .bashrc" -t 5000
  st -e nvim .bashrc
 
elif [ $p == ".fehbg" ];then
  cd $HOME/.dotfiles/
  notify-send "Edit .fehbg" -t 5000
  st -e nvim .fehbg
 
elif [ $p == ".stow-local-ignore" ];then
  cd $HOME/.dotfiles/
  notify-send "Edit .stow-local-ignore" -t 5000
  st -e nvim .stow-local-ignore

elif [ $p == "scripts" ];then
  cd $HOME/.dotfiles/scripts/
  read p <<< $(ls|dmenu)
  notify-send "Edit $p" -t 5000
  st -e nvim $p

else 
  exit 

fi

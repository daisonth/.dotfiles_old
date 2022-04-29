# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias fcd='cd $(ls -a | fzf)'
alias vv='nvim $(fzf)'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias snd='bash .dotfiles/scripts/kdecon.sh && kdeconnect-cli -n RMX2001 --share $(fzf -m)'
alias con='kdeconnect-cli -l'
alias sda1='sudo mount /dev/sda1 /media/'
alias vim='nvim'
alias v='nvim'
alias x='exit'
alias ll='ls -l --color=auto'
alias lla='ls -la --color=auto'
alias add='sudo pacman -S'
alias remove='sudo pacman --remove --recursive'
alias update='sudo pacman -Syyu'
alias hc='herbstclient'

BLK="04" CHR="04" DIR="05" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
alias n='NNN_FIFO=/home/daison/.config/nnn/nnn.fifo nnn -e'
export NNN_PLUG='v:imgview;p:preview-tui;k:kdeconnect;f:fixname;g:fzcd'

PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"

# kdeconnect-cli -n RMX2001 --share $(cat .config/cfiles/clipboard)

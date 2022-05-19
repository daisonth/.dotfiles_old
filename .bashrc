# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias s='startx'
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
alias ls='exa'
alias ll='exa -l'
alias lla='exa -la'
alias tree='exa --tree'
alias add='sudo pacman -S'
alias remove='sudo pacman --remove --recursive'
alias update='sudo pacman -Syyu'
alias hc='herbstclient'

BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
#alias n='NNN_FIFO=/home/daison/.config/nnn/nnn.fifo nnn -e'
export NNN_PLUG='v:imgview;p:preview-tui;k:kdeconnect;f:fixname;g:fzcd'

if [ -f /usr/share/nnn/quitcd/quitcd.bash_zsh ]; then
    source /usr/share/nnn/quitcd/quitcd.bash_zsh
fi
alias n='n -de'

PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"

# kdeconnect-cli -n RMX2001 --share $(cat .config/cfiles/clipboard)

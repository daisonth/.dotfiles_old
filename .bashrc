# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias snd='kdeconnect-cli -n RMX2001 --share'
alias sda1='sudo mount /dev/sda1 /media/'
alias vim='nvim'
alias x='exit'
alias ll='ls -l --color=auto'
alias lla='ls -la --color=auto'
alias add='sudo xbps-install -S'
alias remove='sudo xbps-remove'
alias n='NNN_FIFO=/home/daisn/.config/nnn/nnn.fifo nnn'
alias v='nvim'
export NNN_PLUG='v:imgview;p:preview-tui'

PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"

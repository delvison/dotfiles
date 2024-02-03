# #############
# aliases
# #############

alias vim="$EDITOR"
alias eZ="$EDITOR $ZDOTDIR/.zshrc"
alias eV="$EDITOR ~/.vimrc"
alias eA="$EDITOR ~/.config/awesome/rc.lua"
alias eI="$EDITOR ~/.config/i3/config"
alias eT="$EDITOR ~/.config/tmux/tmux.conf"
alias eS="$EDITOR ~/.ssh/config"

alias today='date +"%Y%m%d"'
alias weather="curl wttr.in/nyc"

alias qr-read="zbarcam --raw -1 | vim -"
alias tmux="tmux -2"
alias dotfiles="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias "tmux ls"="tmux list-sessions"
alias reload="source $ZDOTDIR/.zshrc"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# Force ncmpcpp to use sane bindings
alias ncmpcpp='ncmpcpp -b .config/ncmpcpp/bindings'
alias "git log"="git log --show-signature"
alias open="xdg-open"

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

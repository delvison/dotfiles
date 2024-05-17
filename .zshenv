export XDG_CONFIG_HOME="$HOME/.config"
export TERMINAL=kitty
export ZDOTDIR="$HOME/.config/zsh"

if [ -n "$(which nvim)" ]; then 
  export VISUAL=$(which nvim)
else
  export VISUAL=$(which vim)
fi
export EDITOR=$VISUAL

export TERM="xterm-256color"
export PATH=$PATH:$HOME/.config/dotfiles/scripts
export PATH=$PATH:$HOME/.local/bin

# golang
export GOPATH="$HOME/.go"
export PATH=$PATH:$GOPATH/bin

# zsh
export ZSH=$HOME/.oh-my-zsh
export EDITOR="$VISUAL"
export NVM_DIR="$HOME/.nvm"

# fzf configuration
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --color=dark,bg+:000099,fg+:232 --ansi"

export BROWSER=librewolf

export PASSWORD_STORE_DIR=${HOME}/.password-store
export PASSWORD_STORE_TOMB_FILE=${HOME}/FILES/10_Data/11_Credentials/tomb/pass.tomb
export PASSWORD_STORE_TOMB_KEY=${HOME}/FILES/10_Data/11_Credentials/tomb/.pass.tomb.key

export ZPLUG_HOME=${HOME}/.zplug
export XDG_CONFIG_HOME="${HOME}/.config"
GPG_TTY=$(tty)
export GPG_TTY

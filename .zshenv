export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$HOME/.config/zsh"

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

# fzf configuration -- https://minsw.github.io/fzf-color-picker/
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#b0aeae,bg:#383838,hl:#67fa93 --color=fg+:#000000,bg+:#5fc28a,hl+:#e6ff00 --color=info:#737373,prompt:#ff8000,pointer:#25695a --color=marker:#6e6a48,spinner:#60c463,header:#c7c265 --ansi'


export ZPLUG_HOME=${HOME}/.zplug
export XDG_CONFIG_HOME="${HOME}/.config"
GPG_TTY=$(tty)
export GPG_TTY

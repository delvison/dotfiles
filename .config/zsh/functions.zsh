# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# cd up until reach a dir with .git
cdp () {
  TEMP_PWD='pwd'
  while [ ! -d .git ]; do
    cd ..
    done
    OLDPWD=$TEMP_PWD
}

edotfiles() {
  $EDITOR $(dotfiles ls-tree -r master --name-only | fzf)
}

loop() {
  while :; do "$@"; [ -z $WAIT ] && sleep 60 || sleep $WAIT; clear; done
}

code(){
  cd $(ls -d ~/code/*/*/* | sort | fzf)
}

vopen() {
  nvim "$(fzf --preview="bat --color=always {}")"
}

clone(){
  FULL=$(echo $1 | sed 's/git@//g; s/\.git//g; s/\:/\//g')
  BASE=$(echo $FULL | cut -d'/' -f1)
  USER=$(echo $FULL | cut -d'/' -f2)
  REPO=$(echo $FULL | cut -d'/' -f3)
  mkdir -p $HOME/code/$BASE/$USER
  git clone $1 $HOME/code/$BASE/$USER/$REPO
  cd $HOME/code/$BASE/$USER/$REPO
}

qr() { qrencode "$1" -t ANSIUTF8 -o -; }

zsh-history() {
  export HISTFILE=~/.zsh_history
  export HISTFILESIZE=1000000000
  export HISTSIZE=1000000000
  setopt INC_APPEND_HISTORY
  export HISTTIMEFORMAT="[%F %T] "
  setopt EXTENDED_HISTORY
  setopt HIST_FIND_NO_DUPS
  setopt HIST_IGNORE_ALL_DUPS
}
zsh-history


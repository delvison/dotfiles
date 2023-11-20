# nodejs on mac
export PATH=$PATH:/usr/local/opt/node@10/bin
[ -z "$(which fzf)" ] &&\
  [ -n "$(which brew)" ] &&\
  brew install fzf &&\
  $(brew --prefix)/opt/fzf/install
echo -e "\033]6;1;bg;red;brightness;40\a"
echo -e "\033]6;1;bg;green;brightness;44\a"
echo -e "\033]6;1;bg;blue;brightness;52\a"

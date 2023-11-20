# install tpm for tmux
if [ ! -d  "${HOME}/.config/tmux/plugins" ]; then
  git clone https://github.com/tmux-plugins/tpm "${HOME}/.config/tmux/plugins"
fi

# vim plug install
install_vim_plugs() {
  if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    echo "...initializing vim plug"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PluginInstall +qall;
  fi
}

# oh-my-zsh install
install_omz() {
  if [ ! -d "$HOME/.oh-my-zsh/" ]; then
    echo "...initializing oh-my-zsh"
    git clone https://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh;
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/zsh-syntax-highlighting;
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/zsh-autosuggestions;
    git clone --depth 1 https://github.com/unixorn/fzf-zsh-plugin.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin
  fi
}

install_themes() {
  # dracula theme install
  if [ ! -d "$HOME/.themes/gnome-terminal-colors-dracula" ]; then
    echo "...initializing dracula theme"
    mkdir -p $HOME/.themes;
    git clone https://github.com/GalaticStryder/gnome-terminal-colors-dracula $HOME/.themes/gnome-terminal-colors-dracula/;
  fi

  # arc theme install
  if [ ! -d "$HOME/.themes/arc-theme" ]; then
    echo "...initializing arc theme"
    mkdir -p $HOME/.themes;
    git clone https://github.com/horst3180/arc-theme $HOME/.themes/arc-theme/;
  fi

  # catppuccin
  if [ ! -f ~/.local/share/xfce4/terminal/colorschemes/catppuccin-machiato.theme ]; then
    mkdir -p ~/.local/share/xfce4/terminal/colorschemes
    curl "https://raw.githubusercontent.com/catppuccin/xfce4-terminal/main/src/catppuccin-macchiato.theme" -o ~/.local/share/xfce4/terminal/colorschemes/catppuccin-machiato.theme
  fi
}

install_yq() {
  if ! hash yq; then
    if uname | grep -q "Linux"; then
      sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
      sudo chmod a+x /usr/local/bin/yq
      yq --version
    fi
  fi
}

install_flathub() {
  if uname | grep -q "Linux"; then
    if ! flatpak remotes | grep -q "flathub"; then
      echo "flatpak: adding flathub as a remote..."
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      flatpak update
    fi
  fi
}

install_rofi() {
  mkdir -p ~/.local/share/rofi/themes/
  [ ! -f "~/.local/share/rofi/themes/rounded-gray-dark.rasi" ] &&\
    wget -q https://raw.githubusercontent.com/newmanls/rofi-themes-collection/master/themes/rounded-gray-dark.rasi -O ~/.local/share/rofi/themes/rounded-gray-dark.rasi &&\
    wget -q https://raw.githubusercontent.com/newmanls/rofi-themes-collection/master/themes/rounded-common.rasi -O ~/.local/share/rofi/themes/rounded-common.rasi
}

install_vim_plugs
install_omz
install_themes
install_yq
install_flathub
install_rofi

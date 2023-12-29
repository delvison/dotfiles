plugins=(git fzf-zsh-plugin)
set -g default-terminal "xterm-256color"

# ------------------------------------------------------------------------------

[[ -f ~/.config/zsh/functions.zsh ]] && source ~/.config/zsh/functions.zsh
[[ -f ~/.config/zsh/aliases.zsh ]] && source ~/.config/zsh/aliases.zsh
[[ -f ~/.config/zsh/zplug.zsh ]] && source ~/.config/zsh/zplug.zsh
[[ -f ~/.config/zsh/prompt.zsh ]] && source ~/.config/zsh/prompt.zsh
[[ -f ~/.config/zsh/tmux.zsh ]] && source ~/.config/zsh/tmux.zsh
[ -n $(uname | grep 'Darwin') ] && source ~/.config/zsh/load_mac.zsh
[ -n $(uname | grep 'Linux') ] && source ~/.config/zsh/load_linux.zsh
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ------------------------------------------------------------------------------

# load custom scripts if exists
if [ -f "$HOME/code/scripts/cli-scripts.sh" ]; then
	source $HOME/code/scripts/cli-scripts.sh
fi

# load private config if exists
if [ -f "$HOME/.config/zsh/private.zsh" ]; then
	source $HOME/.config/zsh/private.zsh
fi

source $ZSH/oh-my-zsh.sh
source $HOME/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.oh-my-zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

xmodmap "${HOME}/.config/xmodmap/.Xmodmap" 2>/dev/null
# uname -a | grep -q NixOS \
# 	&& source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
export FZF_DEFAULT_COMMAND="find . -type f \( -path .git -o -path node_modules \) -prune -o -print"
export TERMINAL=kitty
export VIRSH_DEFAULT_CONNECT_URI="qemu:///system"
export BROWSER=librewolf

# https://github.com/roddhjav/pass-tomb
export PASSWORD_STORE_DIR=${HOME}/.password-store
export PASSWORD_STORE_TOMB_FILE=${HOME}/FILES/10_Data/11_Credentials/tomb/pass.tomb
export PASSWORD_STORE_TOMB_KEY=${HOME}/FILES/10_Data/11_Credentials/tomb/keys/.pass.tomb.key

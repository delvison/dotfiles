xmodmap "${HOME}/.config/xmodmap/.Xmodmap" 2>/dev/null
uname -a | grep -q NixOS \
	&& source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

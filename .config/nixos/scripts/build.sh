#!/usr/bin/env zsh
set -eu

pushd ~/.config/nixos
git --git-dir=$HOME/.dotfiles --work-tree=$HOME diff . | delta --side-by-side
sudo NIXPKGS_ALLOW_INSECURE=1 nixos-rebuild switch --impure --flake ~/.config/nixos#$HOST
print -P -n "%F{green}✅ Nix config successfully built.%F{reset}\n"
echo "💽 committing diff..."
gen=$(nixos-rebuild list-generations | grep current | tr -d '*')
git --git-dir=$HOME/.dotfiles --work-tree=$HOME add .
git --git-dir=$HOME/.dotfiles --work-tree=$HOME commit -S -am "nix: $gen"
popd

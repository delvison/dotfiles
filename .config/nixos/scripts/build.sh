#!/usr/bin/env zsh
set -e

pushd ~/.config/nixos
git --git-dir=$HOME/.dotfiles --work-tree=$HOME diff .
sudo nixos-rebuild switch --impure --flake ~/.config/nixos#$HOST
print -P -n "%F{green}✅ Nix config successfully built.%F{reset}\n"
echo "💽 committing diff..."
gen=$(nixos-rebuild list-generations | grep current | tr -d '*')
git --git-dir=$HOME/.dotfiles --work-tree=$HOME add .
git --git-dir=$HOME/.dotfiles --work-tree=$HOME commit -S -am "nix: $gen"
popd

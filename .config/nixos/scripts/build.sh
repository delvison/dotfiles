#!/usr/bin/env zsh
set -e

pushd ~/.config/nixos
git --git-dir=$HOME/.dotfiles --work-tree=$HOME diff .
sudo nixos-rebuild switch --impure --flake ~/.config/nixos#$HOST
gen=$(nixos-rebuild list-generations | grep current | tr -d '*')
git --git-dir=$HOME/.dotfiles --work-tree=$HOME add .
git --git-dir=$HOME/.dotfiles --work-tree=$HOME commit -S -am "nix: $gen"
popd

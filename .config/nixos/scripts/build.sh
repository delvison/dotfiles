#!/usr/bin/env zsh
set -e

pushd ~/.config/nixos
git --git-dir=/home/npc/.dotfiles --work-tree=/home/npc diff .
sudo nixos-rebuild switch --impure --flake ~/.config/nixos#$HOST
gen=$(nixos-rebuild list-generations | grep current | tr -d '*')
git --git-dir=/home/npc/.dotfiles --work-tree=/home/npc add .
git --git-dir=/home/npc/.dotfiles --work-tree=/home/npc commit -S -am "nix: $gen"
popd

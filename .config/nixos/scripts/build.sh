#!/usr/bin/env zsh
set -eu

pushd ~/.config/nixos
git --git-dir=$HOME/.dotfiles --work-tree=$HOME diff . | delta --side-by-side
sudo NIXPKGS_ALLOW_INSECURE=1 nixos-rebuild ${1} --impure --flake ~/.config/nixos#$HOST
print -P -n "%F{green}● Nix config successfully built.%F{reset}\n"

# Prompt for confirmation before committing changes
while true; do
    echo "Commit changes? (y/n): "
    read choice
    case "$choice" in 
        y|Y ) break;;
        n|N ) exit 0 ;;
        * ) echo "Invalid input. Please enter 'y' or 'n'.";;
    esac
done

if [ $? -eq 0 ]; then
    echo "💽 Committing diff..."
    
    gen=$(nixos-rebuild list-generations | grep current | tr -d '*')
    git --git-dir=$HOME/.dotfiles --work-tree=$HOME add .
    git --git-dir=$HOME/.dotfiles --work-tree=$HOME commit -S -am "nix: $gen"
fi

popd

#!/usr/bin/env bash

upgrade() {
    echo "Current channels:"
    sudo nix-channel --list
    echo
    echo "Adding channel for ${version}"
    sudo nix-channel --add https://nixos.org/channels/nixos-${version} nixos
    sudo NIXPKGS_ALLOW_INSECURE=1 nixos-rebuild --upgrade boot --impure --flake ~/.config/nixos#$HOST

    echo "
Ready to reboot.

If things go wrong you can reboot, select the previous generation, use nix-channel to add the old channel, and then nixos-rebuild boot to make the working generation the default.
    "
}

if [ $# -eq 0 ]; then
    echo "Error: Please provide a version number as an argument."
    exit 1
fi

version=$1

echo "Please review release notes at https://nixos.org/manual/nixos/stable/release-notes#sec-release-${version}"
read -p "Are you sure you want to upgrade to $version? (y|n) " -n 1 -r
echo    # Move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]; then
    upgrade
else
    echo "Upgrade cancelled."
fi

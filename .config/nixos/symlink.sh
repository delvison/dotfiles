#!/usr/bin/env bash

set -e
dir=$(pwd)
HOST=$(hostname)

[[ ! -L "/etc/nixos/configuration.nix" ]] \
  && echo "backing up /etc/nixos/configuration.nix" \
  && sudo cp /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bk

for i in *.nix; do
  echo "linking ./${i} to /etc/nixos"
  sudo ln -fs "${dir}/${i}" "/etc/nixos/${i}"
done

if [ -d "./hosts/$HOST" ]; then
  read -p "link ./hosts/$HOST/configuration.nix to /etc/nixos? (y/n) " yn
  case $yn in 
    [yY] ) echo "linking ${dir}/hosts/${HOST}/configuration.nix to /etc/nixos";
      sudo ln -fs "${dir}/hosts/${HOST}/configuration.nix" /etc/nixos/configuration.nix;
      ;;
    [nN] ) echo exiting...;
      exit;;
    * ) echo invalid response;;
  esac
else
  echo "$HOST not found in ./hosts/"
  hash fzf && {
    config=$(find hosts -name configuration.nix \
    | fzf --prompt="Please choose a config to link to /etc/nixos >")

    [ -n "${config}" ] \
      && echo "linking ${dir}/${config}/ to /etc/nixos" \
      && sudo ln -fs "${dir}/${config}" /etc/nixos/configuration.nix;
  } || {
    echo "configuration.nix not linked."
  }
fi

echo "done."
echo
echo "Run 'sudo nixos-rebuild switch' to apply."

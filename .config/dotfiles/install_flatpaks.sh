#!/usr/bin/env bash

install_flatpaks() {
  if uname | grep -q "Linux"; then
    if flatpak remotes | grep -q "flathub"; then
      flatpak update
      flatpak install -y flathub org.signal.Signal
      flatpak install -y flathub ch.protonmail.protonmail-bridge
      flatpak install -y flathub com.protonvpn.www
    fi
  fi
}

install_flatpaks

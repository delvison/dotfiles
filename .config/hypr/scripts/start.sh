#!/usr/bin/env bash

# wallpaper
swww init &
# swww img /home/npc/Nextcloud/30_Media/31_Images/Wallpaper/nixos1.png &
swww img /home/npc/Nextcloud/30_Media/31_Images/Wallpaper/forest1.jpg &

nm-applet --indicator &
blueman-applet &
waybar &
# dunst & # notifications
swaync &  # notifications
# kwalletd5 &
# kwalletmanager5 &
# klipper &
clipmenud &
udiskie &  # for automounting usb drives when plugged in
nextcloud --background

# https://discourse.nixos.org/t/clicked-links-in-desktop-apps-not-opening-browers/29114/27
exec systemctl --user import-environment PATH
systemctl --user restart xdg-desktop-portal.service

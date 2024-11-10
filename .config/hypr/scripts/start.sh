#!/usr/bin/env bash

# wallpaper
swww init &
# swww img /home/npc/Nextcloud/30_Media/31_Images/Wallpaper/nixos1.png &
swww img /home/npc/Nextcloud/30_Media/31_Images/Wallpaper/forest1.jpg &

nm-applet --indicator &
blueman-applet &
waybar &
dunst &
kwalletd5 &
kwalletmanager5 &
# klipper &
clipmenud &
nextcloud --background

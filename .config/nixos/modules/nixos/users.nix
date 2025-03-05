{ config, lib, pkgs, ... }:

{
  options = {};
  config = {
    users = {
      defaultUserShell = pkgs.zsh;
      groups.plugdev = {};
      users = {
        user = {
          isNormalUser = true;
          description = "user";
          extraGroups = [ 
            "networkmanager" 
          ];
          # packages = with pkgs; [
          #   firefox-esr
          # ];
        };

        npc = {
          isNormalUser = true;
          description = "npc";
          extraGroups = [ 
            "docker"
            "input"
            "keyd"
            "libvirtd"
            "networkmanager" 
            "plugdev"
            "storage"
            "wheel"
          ];
          packages = with pkgs; [
            # pass
            passExtensions.pass-audit
            passExtensions.pass-genphrase
            passExtensions.pass-import
            passExtensions.pass-otp
            passExtensions.pass-tomb
            passExtensions.pass-update
            (pass.withExtensions (ext: with ext; [ pass-audit pass-otp pass-import pass-genphrase pass-update pass-tomb]))
            pass

            # desktop tools
            autotiling  # i3wm
            libinput-gestures  # touchpad gestures - i3wm
            libnotify
            lxappearance  # i3wm
            networkmanagerapplet
            pasystray  # volume in systray -- i3wm
            pavucontrol
            picom  # compositor -- i3wm
            pinentry-rofi
            polybar  # i3wm
            rofi
            rofi-emoji
            rofi-pass
            # rofi-pass-wayland
            rofi-power-menu
            # rofi-wayland
            slurp
            swayidle
            swaylock-effects
            swaynotificationcenter  # notifications in hyperland
            swww
            xss-lock  # i3wm


            # utils
            acpi
            atuin
            bat
            bc
            btop
            blueman
            brightnessctl
            cliphist
            curl
            dunst  # notifications -- i3wm
            flatpak
            fprintd
            fusuma
            fzf
            gnome-software
            gopass
            gparted
            grim
            htop
            hyprshot
            imagemagick
            kwallet-pam
            # libsForQt5.kdeconnect-kde
            libsForQt5.krdc
            libsForQt5.qt5ct
            localsend
            plasma5Packages.plasma-thunderbolt
            # power-profiles-daemon
            # protonmail-bridge
            # protonvpn-gui
            qrencode
            ranger
            rclone
            restic
            socat
            syncthing-tray
            tailscale
            tmux
            torsocks
            usbutils
            virt-viewer
            waybar
            wget
            wl-clipboard
            gammastep
            vifm
            xclip
            xdotool
            # xfce.thunar
            zbar
            zsh

            # security
            age
            librewolf
            openssh
            openvpn
            sshfs
            tor-browser-bundle-bin
            tomb
            mullvad-browser
          ];
        };
      };
    };
  };
}

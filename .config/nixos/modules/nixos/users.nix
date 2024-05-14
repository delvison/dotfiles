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
        };

        npc = {
          isNormalUser = true;
          description = "npc";
          extraGroups = [ 
            "networkmanager" 
            "wheel"
            "libvirtd"
            "plugdev"
            "docker"
            "keyd"
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

            # utils
            acpi
            # alacritty
            atuin
            bat
            bc
            btop
            blueman
            brightnessctl
            cliphist
            curl
            dunst
            firefox
            flatpak
            fprintd
            fusuma
            fzf
            gnome.gnome-software
            gopass
            gparted
            grim
            htop
            imagemagick
            keepassxc
            kwallet-pam
            libnotify
            # libsForQt5.kdeconnect-kde
            libsForQt5.krdc
            libsForQt5.qt5ct
            localsend
            networkmanagerapplet
            pavucontrol
            pinentry-rofi
            plasma5Packages.plasma-thunderbolt
            # power-profiles-daemon
            # protonmail-bridge
            # protonvpn-gui
            qrencode
            ranger
            rclone
            restic
            # rofi
            rofi-emoji
            # rofi-pass
            rofi-pass-wayland
            rofi-power-menu
            rofi-wayland
            slurp
            socat
            swayidle
            swaylock-effects
            swww
            syncthing-tray
            tailscale
            tmux
            torsocks
            usbutils
            virt-viewer
            waybar
            wget
            wl-clipboard
            wlsunset
            xclip
            xdg-utils
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

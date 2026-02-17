{
  config,
  lib,
  pkgs,
  ...
}: {
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
            "audio"
            "docker"
            "input"
            "keyd"
            "kvm"
            "libvirt"
            "libvirtd"
            "qemu-libvirtd"
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
            (pass.withExtensions (ext: with ext; [pass-audit pass-otp pass-import pass-genphrase pass-update pass-tomb]))
            pass
            gopass

            # desktop tools
            autotiling # i3wm
            libinput-gestures # touchpad gestures - i3wm
            libnotify
            lxappearance # i3wm
            networkmanagerapplet
            pasystray # volume in systray -- i3wm
            pavucontrol
            picom # compositor -- i3wm
            pinentry-rofi
            polybar # i3wm
            rofi
            rofi-emoji
            rofi-pass
            # rofi-pass-wayland
            rofi-power-menu
            # rofi-wayland
            slurp
            swayidle
            swaylock-effects
            swaynotificationcenter # notifications in hyperland
            swww
            xss-lock # i3wm
            wofi
            wofi-pass

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
            delta # diff
            dunst # notifications -- i3wm
            flatpak
            fprintd
            fusuma
            fzf
            gnome-software
            gparted
            grim
            htop
            hyprshot
            imagemagick
            kdePackages.kwallet-pam
            # libsForQt5.kdeconnect-kde
            # libsForQt5.krdc
            libsForQt5.qt5ct
            localsend
            # plasma5Packages.plasma-thunderbolt
            # power-profiles-daemon
            protonvpn-gui
            proton-pass
            protonmail-desktop
            qrencode
            ranger
            rclone
            restic
            socat
            # TODO fix syncthing-tray for 25.05
            # syncthing-tray
            tailscale
            tmux
            torsocks
            usbutils
            virt-viewer
            waybar  # bar for hyprland
            waypaper # set wallpaper for hyprland
            ashell # bar for hyprland
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
            tor-browser
            tomb
            mullvad-browser
          ];
        };
      };
    };
  };
}

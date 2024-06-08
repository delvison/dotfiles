{ pkgs,... }:

{
  services = {
    atuin.enable = true;
    blueman.enable = true;
    fail2ban.enable = true;
    pcscd.enable = true;
    power-profiles-daemon.enable = true;
    printing.enable = true;
    upower.enable = true;

    fwupd = {
      enable = true;
      daemonSettings = {
        OnlyTrusted = false;
      };
    };

    # https://github.com/gmodena/nix-flatpak
    flatpak = {
      enable = true;
      update.onActivation = true;
      packages = [
        "com.belmoussaoui.Decoder"  # QR scanner
        "com.github.iwalton3.jellyfin-media-player"
        "com.ktechpit.whatsie"  # whatsapp
        "com.obsproject.Studio"
        "in.srev.guiscrcpy"  # android screen mirroring
        "io.freetubeapp.FreeTube"
        "io.github.martinrotter.rssguard"
        "md.obsidian.Obsidian"
        "org.DolphinEmu.dolphin-emu"  # gamecube emulator
        # "org.fkoehler.KTailctl"
        "org.kde.neochat"
        "org.ppsspp.PPSSPP"  # psp emulator
        "org.signal.Signal"
        "org.keepassxc.KeePassXC"
        "io.github.sigmasd.stimulator"  # keep desktop awake
      ];
    };

    # access syncthing via http://localhost:8384/
    syncthing = {
      enable = true;
      user = "npc";
      dataDir = "/home/npc/Syncthing";
      configDir = "/home/npc/.config/syncthing";
    };

    tor = {
      enable = true;
      client.enable = true;
    };

    openssh = {
      enable = false;
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
      };
    };

    tailscale = {
      enable = true;
      # allow use of exit nodes on tailscale
      useRoutingFeatures = "client";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    displayManager = {
      sddm.enable = true;
    };
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      # Configure keymap in X11
      xkb= {
        variant = "";
        layout = "us";
      };

      desktopManager = {
        plasma5.enable = true;
        # xfce.enable = true;
      };
    };

    # enable fingerprint sensor
    fprintd = {
      enable = true;
    };
  };

  systemd = {
    timers = {
      "battery-alert" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "5m";
          OnUnitActiveSec = "5m";
          Unit = "battery-alert.service";
        };
      };
    };
    services = {
      git-annex-assistant = {
        enable = true;
        description = "git annex assistant";
        unitConfig = {
          Type = "simple";
        };
        serviceConfig = {
          User = "npc";
          ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /home/npc/FILES"; 
          ExecStart = "${pkgs.git-annex}/bin/git-annex assistant --autostart";
        };
        wantedBy = [ "multi-user.target" ];
      };
      opensnitch = {
        description = "Opensnitch Application Firewall Daemon";
        wants = ["network.target"]; 
        after = ["network.target"]; 
        wantedBy = ["multi-user.target"];
        path = [ pkgs.iptables ];
        serviceConfig = {
          Type = "simple";
          PermissionsStartOnly = true;
          ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /etc/opensnitch/rules"; 
          ExecStart = "${pkgs.opensnitch}/bin/opensnitchd -rules-path /etc/opensnitch/rules"; 
          Restart = "always";
          RestartSec = 30;
        };
        enable = false;
      };
      flatpak-update = {
        enable = false;
        description = "update flatpaks";
        unitConfig = {
          Type = "simple";
        };
        serviceConfig = {
          User = "npc";
          ExecStartPre = "${pkgs.bash}/bin/bash -c 'until ping -c 1 ip.me; do sleep 10; done;'";
          ExecStart = "${pkgs.flatpak}/bin/flatpak update -y";
        };
        wantedBy = [ "multi-user.target" ];
      };
      "battery-alert" = {
        enable = true;
        description = "battery alert notifications";
        script = ''
          set -eu
          ${pkgs.bash}/bin/bash -c '/home/npc/.config/dotfiles/scripts/battery-alert'
        '';
        serviceConfig = {
          Type = "oneshot";
          User = "root";
        };
      };
    };
  };
}

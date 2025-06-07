{ pkgs, config, lib,... }:

{
  imports = [
      ../../modules/nixos/systemd/flatpak-update.nix
  ];

  # for gnome-keyring to work properly with hyprland
  # https://discourse.nixos.org/t/login-keyring-did-not-get-unlocked-hyprland/40869/10
  security.pam.services.gdm.enableGnomeKeyring = true;
  security.pam.services.gdm-password.enableGnomeKeyring = true;

  services = {
    atuin.enable = true;
    blueman.enable = true;
    devmon.enable = true;
    fail2ban.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true; # thunar - Mount, trash, and other functionalities
    pcscd.enable = true;
    power-profiles-daemon.enable = true;
    printing.enable = true;
    tumbler.enable = true; # thunar - Thumbnail support for images
    udisks2.enable = true;
    upower.enable = true;

    fwupd = {
      enable = true;
      daemonSettings = {
        OnlyTrusted = false;
      };
    };

    # src: https://github.com/gmodena/nix-flatpak
    flatpak = {
      enable = true;
      update.onActivation = true;
      packages = [
        # "com.belmoussaoui.Decoder"  # QR scanner
        "com.brave.Browser"
        "com.github.iwalton3.jellyfin-media-player"
        "com.ktechpit.whatsie"  # whatsapp
        "com.logseq.Logseq"
        # "com.nextcloud.desktopclient.nextcloud"
        "com.obsproject.Studio"
        "in.srev.guiscrcpy"  # android screen mirroring
        "io.freetubeapp.FreeTube"
        "io.github.hrkfdn.ncspot"  # spotify
        # "io.github.martinrotter.rssguard"
        # "io.github.sigmasd.stimulator"  # keep desktop awake
        "md.obsidian.Obsidian"
        # "org.DolphinEmu.dolphin-emu"  # gamecube emulator
        # "org.fkoehler.KTailctl"
        "org.kde.neochat"
        "org.keepassxc.KeePassXC"
        # "org.ppsspp.PPSSPP"  # psp emulator
        "org.signal.Signal"
      ];

      overrides = {
        global = {
          # Force Wayland by default
          Context.sockets = [
            "wayland" 
            "x11"
            "!fallback-x11"
            "gpg-agent" # Expose GPG agent
            "pcsc" # Expose smart cards (i.e. YubiKey)
          ];

          Environment = {
            # Fix un-themed cursor in some Wayland apps
            XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

            # Force correct theme for some GTK apps
            GTK_THEME = "Adwaita:dark";
          };
        };

        "com.visualstudio.code".Context = {
          filesystems = [
            "xdg-config/git:ro" # Expose user Git config
            "/run/current-system/sw/bin:ro" # Expose NixOS managed software
          ];
          sockets = [
            "gpg-agent" # Expose GPG agent
            "pcsc" # Expose smart cards (i.e. YubiKey)
          ];
        };

        "org.onlyoffice.desktopeditors".Context.sockets = ["x11"]; # No Wayland support
      };
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

    # sound
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      # this config is needed to output hi-res audio to USB DAC
      extraConfig.pipewire.adjust-sample-rate = {
        "context.properties" = {
          "default.clock.rate" = 192000;
          "defautlt.allowed-rates" = [ 44100 48000 88200 96000 176400 192000 ];
          #"default.clock.quantum" = 32;
          #"default.clock.min-quantum" = 32;
          #"default.clock.max-quantum" = 32;
        };
      };

      wireplumber.extraConfig.bluetoothEnhancements = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [
            "a2dp_sink"
            "a2dp_source"
            "bap_sink"
            "bap_source"
          ];
          "bluez5.codecs" = [
            "ldac"
            "aptx"
            "aptx_ll_duplex"
            "aptx_ll"
            "aptx_hd"
            "opus_05_pro"
            "opus_05_71"
            "opus_05_51"
            "opus_05"
            "opus_05_duplex"
            "aac"
            "sbc_xq"
          ];
        };
      };
    };

    displayManager = {
      sddm = {
        enable = false;
        wayland.enable = true;
      };
      ly.enable = false;
      # defaultSession = "cinnamon";
      defaultSession = "none+i3";
    };

    desktopManager = {
      plasma6.enable = false;
    };

    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      # ref: https://nixos.wiki/wiki/AMD_GPU
      videoDrivers = [ "amdgpu" ];
      # Configure keymap in X11
      xkb= {
        variant = "";
        layout = "us";
      };

      desktopManager = {
        cinnamon.enable = true;
        gnome.enable = false;
        mate.enable = false;
        pantheon.enable = false;
        xfce = {
          enable = false;
          noDesktop = true;
          enableXfwm = false;
        };
        xterm.enable = false;
      };
      displayManager = {
        gdm.enable = false;
      };

      # ref: https://nixos.wiki/wiki/I3
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        # config = {
        #   modifier = "Mod4";
        #   gaps = {
        #     inner = 10;
        #     outer = 5;
        #   };
        # };
        extraPackages = with pkgs; [
          dmenu #application launcher most people use
          i3status # gives you the default i3 status bar
          i3lock #default i3 screen locker
          betterlockscreen
          i3blocks #if you are planning on using i3blocks over i3status
          xfce.xfce4-power-manager
          nitrogen  # wallpapers
          libinput
          lxde.lxsession  # for lxpolkit
       ];
      };
    };

    # enable fingerprint sensor
    fprintd = {
      enable = true;
    };

    mpd = {
      enable = true;
      user = "npc";
      musicDirectory = "/home/npc/Music";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "My PipeWire Output"
        }
      '';
    };

    avahi = {
      enable = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };
    # ref: https://wiki.nixos.org/wiki/OpenSnitch
    opensnitch = {
      enable = true;
      rules = {
        systemd-timesyncd = {
          name = "systemd-timesyncd";
          enabled = true;
          action = "allow";
          duration = "always";
          operator = {
            type ="simple";
            sensitive = false;
            operand = "process.path";
            data = "${lib.getBin pkgs.systemd}/lib/systemd/systemd-timesyncd";
          };
        };
        systemd-resolved = {
          name = "systemd-resolved";
          enabled = true;
          action = "allow";
          duration = "always";
          operator = {
            type ="simple";
            sensitive = false;
            operand = "process.path";
            data = "${lib.getBin pkgs.systemd}/lib/systemd/systemd-resolved";
          };
        };
      };
    };
  };

  systemd = {
    user.extraConfig = ''
      DefaultEnvironment="PATH=/run/current-system/sw/bin"
    '';
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
      mpd.environment = {
        # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
        XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.npc.uid}"; 
      };

      git-annex-assistant = {
        enable = false;
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
      "battery-alert" = {
        enable = false;
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
      polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
      };
    };
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
  ];
  environment.systemPackages = (with pkgs.gnomeExtensions; [
    blur-my-shell
    pop-shell
  ]);

  environment.etc = {
    "xdg/gtk-2.0/gtkrc".text = "gtk-error-bell=0";
    "xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
    '';
    "xdg/gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
    '';
    # https://nixos.wiki/wiki/PipeWire
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
  };
}

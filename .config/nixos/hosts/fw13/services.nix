{ pkgs,... }:

{
  services = {
    atuin.enable = true;
    blueman.enable = true;
    fail2ban.enable = true;
    flatpak.enable = true;
    fwupd.enable = true;
    pcscd.enable = true;
    power-profiles-daemon.enable = true;
    printing.enable = true;

    cron = {
      enable = true;
      systemCronJobs = [
        "@reboot      root   kill -9 $(pgrep pcscd)"  # for yubikey
        # "@reboot      npc    git annex assistant --autostart"
        "*/5 * * * *  npc    /home/npc/.config/dotfiles/scripts/battery-alert"
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

    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      # Configure keymap in X11
      xkb= {
        variant = "";
        layout = "us";
      };

      displayManager = {
        sddm.enable = true;
      };
      desktopManager = {
        plasma5.enable = true;
        xfce.enable = true;
      };
    };

    # enable fingerprint sensor
    fprintd = {
      enable = true;
    };
  };

  systemd = {
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
        enable = true;
      };
    };
  };
}

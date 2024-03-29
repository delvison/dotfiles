{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
        # <nixos-hardware/framework/13-inch/7040-amd>
      ./fw13-fingerprint-reader.nix
      ./fw13-palm-rejection.nix
      ./fw13-amd-power.nix
      ../../modules/nixos/keyboard.nix
      ../../modules/nixos/ledger.nix
      ../../modules/nixos/yubikey.nix
      ../../modules/nixos/users.nix
      ../../modules/nixos/tlp.nix
      inputs.home-manager.nixosModules.default
    ];

  nix = {
    settings = {
      experimental-features = [ 
        "nix-command" 
        "flakes" 
      ];
    };

    # Automatic Garbage Collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {
        General = {
		      Experimental = true;
	      };
      };
    };
  };

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = false;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/EFI"; 
      };
      grub = {
        efiSupport = true;
        device = "nodev";
        darkmatter-theme = {
          enable = true;
          style = "nixos";
        };
      };
    };
    initrd.systemd.enable = true;
    plymouth.enable = true;

    # kernelParams = ["quiet"];
    kernelParams = [ "mem_sleep_default=deep" ];

    initrd.luks.devices."luks-f2147384-d376-46e6-af7d-7549d4d3773b".device = "/dev/disk/by-uuid/f2147384-d376-46e6-af7d-7549d4d3773b";
  };

  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  virtualisation = {
    libvirtd.enable = true;

    # enable docker
    docker.enable = true;

    # enable waydroid for android emulation
    # https://nixos.wiki/wiki/WayDroid
    #waydroid.enable = true;
  };

  home-manager = {
	  extraSpecialArgs = { inherit inputs; };
	  users = {
		  "npc" = import ./home.nix;
	  };
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  security = {
    rtkit.enable = true;
    pam.services.kwallet = {
      name = "kwallet";
      enableKwallet = true;
    };
    pam.services.swaylock = {};
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    zsh.enable = true;
    dconf.enable = true;
    virt-manager.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
  };

  services = {
    blueman.enable = true;
    fwupd.enable = true;
    flatpak.enable = true;
    printing.enable = true;

    cron = {
      enable = true;
      systemCronJobs = [
        "@reboot      npc    git annex assistant --autostart"
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
      };
    };

    # enable fingerprint sensor
    fprintd = {
      enable = true;
    };
  };

  # qt = {
  #   enable = true;
  #   platformTheme = "gnome";
  #   style = "adwaita-dark";
  # };

  networking = {
    networkmanager.enable = true;
    hostName = "fw13";
    nameservers = [ 
      "100.100.100.100" # https://tailscale.com/kb/1063/install-nixos/#using-magicdns
      "192.168.50.3" 
      "192.168.1.224" 
      "192.168.1.1"
      "9.9.9.9" 
    ];
    firewall = { 
      enable = true;
      allowedTCPPortRanges = [ 
        { from = 1714; to = 1764; } # KDE Connect
      ];  
      allowedUDPPortRanges = [ 
        { from = 1714; to = 1764; } # KDE Connect
      ];  
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

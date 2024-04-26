{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports =
    [
      ./hardware-configuration.nix
      ./fw13-fingerprint-reader.nix
      ./fw13-palm-rejection.nix
      ./nix.nix
      ./networking.nix
      ./services.nix
      ../../modules/nixos/keyboard.nix
      ../../modules/nixos/yubikey.nix
      ../../modules/nixos/users.nix
      # ../../modules/nixos/tlp.nix
      # ./fw13-amd-power.nix
      # ../../modules/nixos/ledger.nix
      # <nixos-hardware/framework/13-inch/7040-amd>
      inputs.home-manager.nixosModules.default
    ];

  nixpkgs.overlays = [ (final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
    }) 
  ];

  hardware = {
    pulseaudio.enable = false;
    ledger.enable = true;
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

  # Enable sound with pipewire.
  sound.enable = true;

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        # efiSysMountPoint = "/boot/EFI";
      };
      # grub = {
      #   efiSupport = true;
      #   device = "nodev";
      #   darkmatter-theme = {
      #     enable = true;
      #     style = "nixos";
      #   };
      # };
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
    # https://libvirt.org/manpages/libvirtd.html
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

  security = {
    sudo.execWheelOnly = true;
    rtkit.enable = true;
    pam.services.kwallet = {
      name = "kwallet";
      enableKwallet = true;
    };
    # swaylock is used in hyprland
    pam.services.swaylock = {};
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs;
    [
      unstable.power-profiles-daemon
      unstable.python3
      vim
      pinentry-curses
    ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs = {
    adb.enable = true;
    gnupg.agent = {
      enable = true;
      # pinentryFlavor = "curses";
      enableSSHSupport = true;
    };

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
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

  # qt = {
  #   enable = true;
  #   platformTheme = "gnome";
  #   style = "adwaita-dark";
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

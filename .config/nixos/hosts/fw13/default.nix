{
  config,
  pkgs,
  unstablePkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./fw13-fingerprint-reader.nix
    ./fw13-palm-rejection.nix
    ./nix.nix
    ./networking.nix
    ./services.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/keyboard.nix
    ../../modules/nixos/yubikey.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/firejail.nix
    ../../modules/nixos/desktop-gnome.nix
    # ../../modules/nixos/desktop-cosmic.nix
    # ../../modules/nixos/tlp.nix
    # ./fw13-amd-power.nix
    # ../../modules/nixos/ledger.nix
    # <nixos-hardware/framework/13-inch/7040-amd>
  ];

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-27.3.11"
    ];
  };

  nixpkgs.overlays = [
    (final: _prev: {
      unstable = import inputs.nixpkgs-unstable {
        system = final.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    })
  ];

  hardware = {
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
  # sound.enable = true;

  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        # efiSysMountPoint = "/boot/EFI";
      };
      # grub = {
      #   enable = true;
      #   # useOSProber = true;
      #   efiSupport = true;
      #   efiInstallAsRemovable = true;
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
    kernelParams = ["mem_sleep_default=deep" "amd_iommu=on"];

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
    spiceUSBRedirection.enable = true;
    # https://libvirt.org/manpages/libvirtd.html
    # https://nixos.wiki/wiki/Libvirt
    libvirtd = {
      enable = true;
      qemu = {
        vhostUserPackages = [pkgs.virtiofsd];
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        # ovmf = {
        #   enable = true;
        #   packages = [
        #     (pkgs.OVMF.override {
        #       secureBoot = true;
        #       tpmSupport = true;
        #     }).fd
        #   ];
        # };
      };
    };

    # enable docker - https://nixos.wiki/wiki/Docker
    docker.enable = true;

    # enable waydroid for android emulation
    # https://nixos.wiki/wiki/WayDroid
    #waydroid.enable = true;
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

  xdg.portal = {
    enable = true;
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    xdgOpenUsePortal = true;
  };

  programs = {
    adb.enable = true;
    gnupg.agent = {
      enable = true;
      # pinentryFlavor = "curses";
      enableSSHSupport = true;
    };

    # ref: https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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

  # for i3wm
  # ref: https://nixos.wiki/wiki/I3
  environment.pathsToLink = ["/libexec"];

  # https://discourse.nixos.org/t/login-keyring-did-not-get-unlocked-hyprland/40869/10
  # environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID"; # set the runtime directory

  security.polkit.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

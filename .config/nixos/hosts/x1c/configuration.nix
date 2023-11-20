{ config, pkgs, ... }:

{
  imports =
    [ 
      /etc/nixos/hardware-configuration.nix
      /etc/nixos/keyboard.nix
      /etc/nixos/ledger.nix
      # /etc/nixos/network-drives.nix
      /etc/nixos/xfce.nix
      /etc/nixos/yubikey.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-149b0f5b-4c66-4d9e-9d48-72174467ed87".device = "/dev/disk/by-uuid/149b0f5b-4c66-4d9e-9d48-72174467ed87";

  boot.extraModprobeConfig = "options kvm_intel nested=1";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nameservers = [ 
    "100.100.100.100" # https://tailscale.com/kb/1063/install-nixos/#using-magicdns
    "192.168.50.3" 
    "192.168.1.224" 
    "192.168.1.1"
    "9.9.9.9" 
  ];
  networking.search = [ "local.lan" ];

  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };

  time.timeZone = "America/New_York";

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

  # enable docker
  virtualisation.docker.enable = true;

  services.xserver = {
    enable = true;
    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
    # Enable automatic login for the user.
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "npc";
      sddm.enable = true;
      # lightdm.enable = true;
    };
    # Desktop Environment
    desktopManager.xfce.enable = true;
    desktopManager.plasma5.enable = true;

    #nix-prefetch-url --name displaylink.zip https://www.synaptics.com/sites/default/files/exe_files/2023-04/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.7-EXE.zip
    # videoDrivers = [ "displaylink" "modesetting" ];
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  xdg.portal.enable = true;

  users.defaultUserShell = pkgs.zsh;
  users.groups.plugdev = {};
  users.users.npc = {
    isNormalUser = true;
    description = "npc";
    extraGroups = [ 
      "networkmanager" 
      "wheel"
      "libvirtd"
      "plugdev"
      "docker"
    ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
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
    curl
    flatpak
    fzf
    gnome.gnome-software
    htop
    restic
    socat
    tmux
    torsocks
    wget
    zsh
    plasma5Packages.plasma-thunderbolt

    # security
    age
    librewolf
    openssh
    openvpn
    sshfs
    tor-browser-bundle-bin
    mullvad-browser

    # yubikey packages
    age-plugin-yubikey
    libykclient
    libyubikey
    yubico-pam
    yubico-piv-tool
    yubikey-agent
    yubikey-manager
    yubikey-personalization
    yubikey-touch-detector

    # fonts
    fira
    fira-mono
    fira-code
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.zsh.enable = true;

  programs.dconf.enable = true;

  # List services that you want to enable:
  services = {
    flatpak.enable = true;

    # access syncthing via http://localhost:8384/
    syncthing = {
        enable = true;
        user = "npc";
        dataDir = "/home/npc/Syncthing";
        configDir = "/home/npc/.config/syncthing";
    };

    # enable tor
    tor.enable = true;
    tor.client.enable = true;

    # enable the OpenSSH daemon.
    openssh.enable = true;

    # enable tailscale
    tailscale.enable = true;
    # allow use of exit nodes on tailscale
    tailscale.useRoutingFeatures = "client";
  };

  powerManagement.powertop.enable = true;
  services.thermald.enable = true;

  # thunderbolt
  services.hardware.bolt.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

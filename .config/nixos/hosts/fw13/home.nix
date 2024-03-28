{
  config,
  pkgs,
  lib,
  flake-inputs,
  ...
}: {
  imports = [
      # flake-inputs.nix-flatpak.homeManagerModules.nix-flatpak
      ../../modules/home-manager/packages.nix
  ];

  home = {
    stateVersion = "23.11";
    username = "npc";
    homeDirectory = "/home/npc";
  };

  nixpkgs = {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "openssl-1.1.1w"
      "electron-24.8.6"
      "electron-25.9.0"
    ];
  };

  home.file = {
    ".gitconfig".text = ''
    [credential "https://gitea.donttrackme.xyz"]
      helper = "!f() { test \"$1\" = get && echo \"username=$(pass homelab/server/gitea/personal | grep login | awk '{print $2}')\npassword=$(pass homelab/server/gitea/personal | grep token | awk '{print $2}')\"; }; f"

    [credential "https://github.com"]
      helper = "!f() { test \"$1\" = get && echo \"username=$(pass github.com/personal | grep login | awk '{print $2}')\npassword=$(pass github.com/personal | grep api-key | awk '{print $2}')\"; }; f"
    '';

    # ".config/git-annex/autostart".text = ''
    #   ~/.electrum
    #   ~/.password-store
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    OBSIDIAN_USE_WAYLAND = "1";
    _JAVA_OPTIONS = "-Dsun.security.smartcardio.library=${lib.getLib pkgs.pcsclite}/lib/libpcsclite.so";
  };

  # libvirt
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.nightfox-gtk-theme;
      name = "Nightfox-Dusk-BL";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    font = {
      name = "Fira Sans";
      size = 11;
    };
  };

  # services.flatpak.packages = [
  #   "com.protonvpn.www"
  # ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

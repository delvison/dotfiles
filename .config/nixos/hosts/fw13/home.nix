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

    ".config/git-annex/autostart".text = ''
      ~/FILES
    '';
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
    package = pkgs.simp1e-cursors;
    name = "Simp1e-Gruvbox-Dark";
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.palenight-theme;
      name = "palenight";
    };

    iconTheme = {
      package = pkgs.vimix-icon-theme;
      name = "Vimix-Beryl";
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

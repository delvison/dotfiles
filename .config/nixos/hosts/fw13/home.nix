{
  config,
  pkgs,
  lib,
  flake-inputs,
  ...
}: {
  imports = [
      ../../modules/home-manager/packages.nix
      ../../modules/home-manager/packages-dev.nix
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

    # directories for git-annex assistant to monitor
    ".config/git-annex/autostart".text = ''
      /home/npc/FILES
    '';

    ".local/share/applications/ykfix.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Run YKFix Script
      Comment=Launches the ykfix script
      Exec=kitty --detach -c /bin/bash /home/npc/.config/dotfiles/scripts/ykfix
      Terminal=true
      Categories=Utility;
    '';

    # ".config/xdg-desktop-portal/hyprland-portals.conf".text = ''
    #   [preferred]
    #   default=hyprland;gtk
    # '';
  };

  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "nvim";
    GTK_THEME = "Adwaita:dark";
    GTK_USE_PORTAL = "1";
    _JAVA_OPTIONS = "-Dsun.security.smartcardio.library=${lib.getLib pkgs.pcsclite}/lib/libpcsclite.so";
    NIXOS_OZONE_WL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    OBSIDIAN_USE_WAYLAND = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORMTHEME = "gtk3";
    # QT_QPA_PLATFORMTHEME="qt6ct";
    # QT_QPA_PLATFORM = "wayland-egl";
    QT_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # SDL_VIDEODRIVER = "wayland";
    TERMINAL = "kitty";
    WLR_NO_HARDWARE_CURSORS = "1"; # if no cursor,uncomment this line  
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

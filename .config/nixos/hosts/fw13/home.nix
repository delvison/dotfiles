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
    ../../modules/home-manager/neovim.nix
    ../../modules/home-manager/dconf.nix
  ];

  home = {
    stateVersion = "25.05";
    username = "npc";
    homeDirectory = "/home/npc";
    sessionPath = ["$HOME/.local/bin"];
  };

  home.file = {
    ".gitconfig".text = ''
           [gcrypt]
             require-explicit-force-push = false
           [column]
             ui = auto
           [branch]
             sort = -committerdate
           [tag]
             sort = version:refname
           [init]
             defaultBranch = main
           [diff]
             algorithm = histogram
             colorMoved = plain
             mnemonicPrefix = true
             renames = true
           [push]
             default = simple
             autoSetupRemote = true
             followTags = true
           [fetch]
             prune = true
             pruneTags = true
             all = true
           [help]
             autocorrect = prompt
           [commit]
             verbose = true
           [rerere]
             enabled = true
             autoupdate = true
           [core]
             excludesfile = ~/.gitignore
           [rebase]
             autoSquash = true
             autoStash = true
             updateRefs = true
           [merge]
             conflictstyle = zdiff3
           [alias]
      co = checkout
      br = branch
      st = status
      lg = log --oneline --graph --decorate -20
      graph = log --oneline --graph --all -30
      last = log -1 --stat
      unstage = reset HEAD --
      undo = reset --soft HEAD~1
      amend = commit --amend --no-edit

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

    # https://github.com/netbrain/zwift/discussions/38
    # "zwift.sh" = {
    #   source = pkgs.fetchurl {
    #     url = "https://raw.githubusercontent.com/netbrain/zwift/master/zwift.sh";
    #     hash = "sha256-IIuYNzntS90wI4ycxO4T58RnbjUqevp2g4PKzGT8FSw=";
    #   };
    #   target = ".local/bin/zwift";
    #   executable = true;
    # };
  };

  # define env vars here
  home.sessionVariables = {
    BROWSER = "firefox";
    EDITOR = "nvim";
     GTK_THEME = "Everforest-Dark-B";
    GTK_USE_PORTAL = "1";
    _JAVA_OPTIONS = "-Dsun.security.smartcardio.library=${lib.getLib pkgs.pcsclite}/lib/libpcsclite.so";
    NIXOS_OZONE_WL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    OBSIDIAN_USE_WAYLAND = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORMTHEME = "gtk3";
    # QT_STYLE = "adwaita-dark";
    # QT_QPA_PLATFORMTHEME="qt6ct";
    # QT_QPA_PLATFORM = "wayland-egl";
    QT_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # SDL_VIDEODRIVER = "wayland";
    TERMINAL = "kitty";
    VIRSH_DEFAULT_CONNECT_URI = "qemu:///system";  # virsh without sudo
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
      name = "Everforest-Dark-B";
      package = pkgs.everforest-gtk-theme;
    };
    iconTheme = {
      package = pkgs.vimix-icon-theme;
      name = "vimix-jade";
    };
    font = {
      name = "Fira Sans";
      size = 11;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  # ref: https://wiki.nixos.org/wiki/OpenSnitch
  services.opensnitch-ui.enable = true;

  # Kitty terminal configuration with Everforest Dark Medium theme
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      size = 14;
    };
    settings = {
      enable_audio_bell = false;
      scrollback_lines = 10000;
      update_check_interval = 0;
      
      # Everforest Dark Medium theme colors
      foreground = "#d3c6aa";
      background = "#2d353b";
      selection_foreground = "#9da9a0";
      selection_background = "#505a60";
      
      cursor = "#d3c6aa";
      cursor_text_color = "#343f44";
      
      url_color = "#7fbbb3";
      
      active_border_color = "#a7c080";
      inactive_border_color = "#56635f";
      bell_border_color = "#e69875";
      visual_bell_color = "none";
      
      wayland_titlebar_color = "system";
      macos_titlebar_color = "system";
      
      active_tab_background = "#13141d";
      active_tab_foreground = "#d3c6aa";
      inactive_tab_background = "#3d484d";
      inactive_tab_foreground = "#9da9a0";
      tab_bar_background = "#343f44";
      tab_bar_margin_color = "none";
      
      mark1_foreground = "#2d353b";
      mark1_background = "#7fbbb3";
      mark2_foreground = "#2d353b";
      mark2_background = "#d3c6aa";
      mark3_foreground = "#2d353b";
      mark3_background = "#d699b6";
      
      # Color palette
      color0 = "#343f44";
      color1 = "#e67e80";
      color2 = "#a7c080";
      color3 = "#dbbc7f";
      color4 = "#7fbbb3";
      color5 = "#d699b6";
      color6 = "#83c092";
      color7 = "#859289";
      color8 = "#868d80";
      color9 = "#e67e80";
      color10 = "#a7c080";
      color11 = "#dbbc7f";
      color12 = "#7fbbb3";
      color13 = "#d699b6";
      color14 = "#83c092";
      color15 = "#9da9a0";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

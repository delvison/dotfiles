# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{lib, ...}:
let
  inherit (lib.hm.gvariant) mkTuple mkUint32;
in {
  # https://github.com/nix-community/dconf2nix
  dconf = {
    enable = true;
  };

  dconf.settings = {
    "org/gnome/Console" = {
      custom-font = "Adwaita Mono 18";
      last-window-maximised = false;
      last-window-size = mkTuple [620 365];
      use-system-font = false;
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/vnc-l.png";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/vnc-d.png";
      primary-color = "#77767B";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/interface" = {
      accent-color = "green";
      color-scheme = "prefer-dark";
      cursor-blink = true;
      cursor-blink-time = 1200;
      enable-animations = true;
      gtk-key-theme = "";
      # gtk-theme = "everforest-dark";
      # icon-theme = "Vimix-Beryl";
      # gtk-theme = "vimix-dark-doder";
      # icon-theme = "Vimix-jade-dark";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    # "org/gnome/desktop/wm/custom-keybindings" = [
    #   "/org/gnome/desktop/wm/custom-keybindings/custom0/"
    # ];

    # "org/gnome/desktop/wm/custom-keybindings/custom0" = {
    #   binding = "<Super>grave";
    #   command = "wofi-pass";
    #   name = "wofi-pass";
    # };

    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Shift><Super>c"];
      move-to-workspace-2 = ["<Shift><Super>2"];
      move-to-workspace-3 = ["<Shift><Super>3"];
      move-to-workspace-4 = ["<Shift><Super>4"];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-schedule-automatic = true;
    };

    "org/gnome/shell" = {
      disabled-extensions = [];
      enabled-extensions = ["blur-my-shell@aunetx" "arcmenu@arcmenu.com" "clipboard-history@alexsaveau.dev" "dash2dock-lite@icedman.github.com" "mediacontrols@cliffniff.github.com" "bitcoin-price-checker@misfits.dev" "bitcoin-markets@ottoallmendinger.github.com" "just-perfection-desktop@just-perfection" "IP-Finder@linxgem33.com" "ProxySwitcher@flannaghan.com" "user-theme-x@tuberry.github.io" "space-bar@luchrioh" "switcher@landau.fi"];
      favorite-apps = ["org.gnome.Epiphany.desktop" "org.gnome.Nautilus.desktop" "io.freetubeapp.FreeTube.desktop" "librewolf.desktop" "org.gnome.Console.desktop" "com.github.iwalton3.jellyfin-media-player.desktop" "com.mastermindzh.tidal-hifi.desktop"];
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/com-flannaghan-ProxySwitcher" = {
      active-mode = "manual";
    };

    "org/gnome/shell/extensions/dash2dock-lite" = {
      animation-bounce = 0.75;
      animation-magnify = 0.3;
      animation-rise = 0.25;
      animation-spread = 0.75;
      autohide-dash = false;
      autohide-speed = 0.5;
      border-radius = 3.0;
      dock-padding = 0.5;
      favorites-only = true;
      icon-effect = 0;
      icon-size = 0.43103448275862066;
      icon-spacing = 0.5;
      items-pullout-angle = 0.5;
      mounted-icon = true;
      msg-to-ext = "";
      preferred-monitor = 0;
      pressure-sense = false;
      pressure-sense-sensitivity = 0.4;
      running-indicator-style = 1;
      scroll-sensitivity = 0.4;
      shrink-icons = true;
    };

    "org/gnome/shell/extensions/just-perfection" = {
      accent-color-icon = true;
      accessibility-menu = true;
      animation = 3;
      background-menu = true;
      clock-menu-position = 0;
      controls-manager-spacing-size = 0;
      dash = true;
      dash-icon-size = 0;
      double-super-to-appgrid = true;
      max-displayed-search-results = 0;
      osd = true;
      panel = true;
      panel-in-overview = true;
      ripple-box = true;
      search = true;
      show-apps-button = true;
      startup-status = 1;
      support-notifier-showed-version = 34;
      support-notifier-type = 0;
      theme = false;
      window-demands-attention-focus = false;
      window-picker-icon = true;
      window-preview-caption = true;
      window-preview-close-button = true;
      workspace = true;
      workspace-background-corner-size = 0;
      workspace-popup = true;
      workspaces-in-app-grid = true;
    };

    "org/gnome/shell/extensions/mediacontrols" = {
      colored-player-icon = true;
      extension-index = mkUint32 1;
      extension-position = "Left";
      hide-media-notification = true;
      label-width = mkUint32 550;
      show-control-icons-seek-backward = false;
      show-control-icons-seek-forward = false;
      show-player-icon = true;
    };

    "org/gnome/shell/extensions/space-bar/appearance" = {
      application-styles = ".space-bar {n  -natural-hpadding: 12px;n}nn.space-bar-workspace-label.active {n  margin: 0 4px;n  background-color: rgba(255,255,255,0.3);n  color: rgba(255,255,255,1);n  border-color: rgba(0,0,0,0);n  font-weight: 700;n  border-radius: 4px;n  border-width: 0px;n  padding: 3px 8px;n}nn.space-bar-workspace-label.inactive {n  margin: 0 4px;n  background-color: rgba(0,0,0,0);n  color: rgba(255,255,255,1);n  border-color: rgba(0,0,0,0);n  font-weight: 700;n  border-radius: 4px;n  border-width: 0px;n  padding: 3px 8px;n}nn.space-bar-workspace-label.inactive.empty {n  margin: 0 4px;n  background-color: rgba(0,0,0,0);n  color: rgba(255,255,255,0.5);n  border-color: rgba(0,0,0,0);n  font-weight: 700;n  border-radius: 4px;n  border-width: 0px;n  padding: 3px 8px;n}";
    };

    "org/gnome/shell/extensions/user-theme-x" = {
      color = true;
      cursor = true;
      dark-color = "green";
      dark-gtk = "vimix-dark-doder";
      dark-icon = "Vimix-amethyst-dark";
      dark-shell = "";
      dark-style = "prefer-dark";
      gtk = true;
      icon = true;
      light-color = "green";
      light-gtk = "vimix-dark-doder";
      light-icon = "Vimix-jade-dark";
      light-shell = "";
      light-style = "prefer-dark";
      shell = true;
      style = true;
    };
  };
}

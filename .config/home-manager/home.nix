{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "npc";
  home.homeDirectory = "/home/npc";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
    "electron-24.8.6"
  ];

  fonts.fontconfig.enable = true;
  gtk.font = "Fira";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    (pkgs.nerdfonts.override { fonts = [ "CascadiaCode" "FiraMono" "Ubuntu" ]; })
    cascadia-code
    fira
    iosevka
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    ubuntu_font_family

    # blockchain
    electrum
    ledger_agent
    ledger-live-desktop
    ledger-udev-rules
    monero-cli
    monero-gui
    python311Packages.ckcc-protocol
    sparrow

    # utils
    alacritty
    bat
    firefox
    fprintd
    gopass
    gparted
    imagemagick
    keepassxc
    libnotify
    libsForQt5.kdeconnect-kde
    libsForQt5.krdc
    protonmail-bridge
    protonvpn-gui
    qrencode
    ranger
    rclone
    syncthing-tray
    tailscale
    xclip
    virt-viewer
    wl-clipboard
    zbar

    # office
    gnome-decoder
    libreoffice
    logseq
    mupdf
    nextcloud-client
    obsidian

    # media
    calibre
    feh
    nicotine-plus
    kdenlive
    mpv
    picard
    vlc
    yt-dlp

    # communication
    cinny-desktop
    gajim
    signal-desktop
    slack
    telegram-desktop
    thunderbird
    zoom-us

    # dev
    ansible
    bats
    gh
    git
    git-annex
    git-remote-gcrypt
    go
    gopls
    gnumake
    jq
    neovim
    openssl
    python3
    python311Packages.pip
    tree
    vim 
    vscode
    yq

    # theme
    catppuccin-gtk
    catppuccin-kvantum
    catppuccin-papirus-folders
    elementary-xfce-icon-theme
    libsForQt5.qtstyleplugin-kvantum
    nordic
    nordzy-icon-theme
    tela-circle-icon-theme
    vimix-icon-theme
    zuki-themes

    # desktop QOL
    digikam
    rofi
    rofi-emoji
    rofi-pass

    # gstreamer packages need for sound streaming while using SPICE on
    # virt-viewer
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-bad
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".gitconfig".text = ''
    [credential "https://gitea.donttrackme.xyz"]
      helper = "!f() { test \"$1\" = get && echo \"username=$(pass homelab/server/gitea/personal | grep login | awk '{print $2}')\npassword=$(pass homelab/server/gitea/personal | grep token | awk '{print $2}')\"; }; f"

    [credential "https://github.com"]
      helper = "!f() { test \"$1\" = get && echo \"username=$(pass github.com/personal | grep login | awk '{print $2}')\npassword=$(pass github.com/personal | grep api-key | awk '{print $2}')\"; }; f"
    '';

    ".config/git-annex/autostart".text = ''
      ~/.electrum
      ~/.password-store
      ~/FILES
    '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/npc/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # libvirt
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

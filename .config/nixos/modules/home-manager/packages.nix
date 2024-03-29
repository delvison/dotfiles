{ config, pkgs, ... }:

{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # fonts
    (pkgs.nerdfonts.override { fonts = [ "CascadiaCode" "FiraMono" "Ubuntu" ]; })
    cascadia-code
    fira
    fira-code
    fira-mono
    iosevka
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk
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
    acpi
    alacritty
    bat
    blueman
    brightnessctl
    cliphist
    dunst
    firefox
    fprintd
    gopass
    gparted
    grim
    imagemagick
    keepassxc
    kwallet-pam
    libnotify
    libnotify
    libsForQt5.kdeconnect-kde
    libsForQt5.krdc
    libsForQt5.qt5ct
    networkmanagerapplet
    pavucontrol
    pinentry-rofi
    protonmail-bridge
    protonvpn-gui
    qrencode
    ranger
    rclone
    # rofi
    rofi-emoji
    # rofi-pass
    rofi-pass-wayland
    rofi-power-menu
    rofi-wayland
    slurp
    swayidle
    swaylock-effects
    swww
    syncthing-tray
    tailscale
    virt-viewer
    waybar
    wl-clipboard
    wlsunset
    xclip
    xdg-utils
    xfce.thunar
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
    webcord # discord
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
    just
    neovim
    openssl
    python3
    python311Packages.pip
    tree
    vscode
    yq

    # theme
    catppuccin-gtk
    catppuccin-kvantum
    catppuccin-papirus-folders
    libsForQt5.qtstyleplugin-kvantum
    nordzy-icon-theme
    tela-circle-icon-theme
    vimix-icon-theme
    zuki-themes

    # desktop QOL
    digikam

    # gstreamer packages need for sound streaming while using SPICE on
    # virt-viewer
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-bad
  ];
}

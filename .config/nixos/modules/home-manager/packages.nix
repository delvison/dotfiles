{ config, pkgs, ... }:

{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    (pkgs.nerdfonts.override { fonts = [ "CascadiaCode" "FiraMono" "Ubuntu" ]; })
    cascadia-code
    fira
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
    just
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
}

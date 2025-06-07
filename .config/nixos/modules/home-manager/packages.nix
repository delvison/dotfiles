{
  config,
  pkgs,
  ...
}:
  let
    unstable = import
      (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/68e06b5c7298cad3993b27cf60c67c80edbb3c2d)
      # reuse the current configuration
      { config = config.nixpkgs.config; };
  in
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
    # iosevka
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    ubuntu_font_family

    # blockchain
    unstable.bitcoind-knots
    # electrum
    ledger_agent
    # ledger-live-desktop
    ledger-udev-rules
    # monero-cli
    # monero-gui
    python311Packages.ckcc-protocol
    unstable.sparrow

    # office
    # gnome-decoder
    joplin
    libreoffice
    # logseq
    mupdf
    pandoc
    tectonic  # pdf engine for pandoc
    nextcloud-client
    zathura

    # media
    calibre
    catt  # chromecast
    digikam  # photos
    feh
    kdenlive
    mpc-cli
    mpv
    # ncmpcpp
    nicotine-plus
    picard
    playerctl # media controls
    rhythmbox  # music
    sonixd  # subsonic music client
    quodlibet  # music
    ueberzug # allows images on terminal
    # vlc
    yt-dlp

    # communication
    # cinny-desktop  # matrix client
    # gajim  # xmpp client
    # signal-desktop
    simplex-chat-desktop
    # slack
    # telegram-desktop
    thunderbird
    # webcord # discord
    zoom-us

    # theme/desktop
    catppuccin-gtk
    catppuccin-kvantum
    gnomeExtensions.unite
    # gnomeExtensions.weather
    # gnomeExtensions.weather-oclock
    gnomeExtensions.yakuake
    libsForQt5.qtstyleplugin-kvantum
    nightfox-gtk-theme
    nordzy-icon-theme
    ocs-url
    papirus-icon-theme
    vimix-icon-theme
    zuki-themes

    # gstreamer packages need for sound streaming while using SPICE on virt-viewer
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-bad

    # util
    arandr
    bashmount
    dig
    gvfs
    magic-wormhole # fileshare
    lsof
    lua51Packages.luarocks  # for nvim
    # opensnitch
    # opensnitch-ui
    proxychains
    redshift
    ripgrep
    sensible-utils
    udisks2 
    udiskie  # for automounting usb drives when plugged in
    unstable.hyprlock
    wine64
    winetricks
    # xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];
}

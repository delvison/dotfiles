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
    unstable.sparrow

    # office
    gnome-decoder
    libreoffice
    logseq
    mupdf
    pandoc
    tectonic  # pdf engine for pandoc
    nextcloud-client
    zathura

    # media
    calibre
    digikam  # photos
    feh
    kdenlive
    mpc-cli
    mpv
    ncmpcpp
    nicotine-plus
    picard
    playerctl # media controls
    rhythmbox
    sonixd  # subsonic music client
    ueberzug
    vlc
    yt-dlp

    # communication
    cinny-desktop  # matrix client
    gajim  # xmpp client
    # signal-desktop
    # slack
    # telegram-desktop
    thunderbird
    # webcord # discord
    zoom-us

    # theme
    catppuccin-gtk
    nightfox-gtk-theme
    catppuccin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    papirus-icon-theme
    nordzy-icon-theme
    vimix-icon-theme
    zuki-themes
    ocs-url

    # gstreamer packages need for sound streaming while using SPICE on virt-viewer
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-bad

    # util
    bashmount
    dig
    gvfs
    magic-wormhole
    opensnitch
    opensnitch-ui
    proxychains
    sensible-utils
    udisks2 
    unstable.hyprlock
    wine64
    winetricks
  ];
}

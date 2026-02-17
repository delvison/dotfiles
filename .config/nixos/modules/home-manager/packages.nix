{
  config,
  pkgs,
  unstablePkgs,
  inputs,
  ...
}: let
  unstablePackages = with unstablePkgs; [
    sparrow
    simplex-chat-desktop
    hyprlock
  ];
in {
  home.packages = with pkgs; ([
      kitty
      cascadia-code
      fira
      fira-code
      fira-mono
      # iosevka
      jetbrains-mono
      # noto-fonts
      # noto-fonts-cjk-sans
      noto-fonts-color-emoji
      ubuntu-classic

      # blockchain
      # electrum
      # ledger-agent  # broken in 25.11
      # ledger-live-desktop
      ledger-udev-rules
      # monero-cli
      # monero-gui
      python311Packages.ckcc-protocol

      # office
      # gnome-decoder
      joplin
      libreoffice
      # logseq
      mupdf
      pandoc
      tectonic # pdf engine for pandoc
      nextcloud-client
      zathura

      # media
      calibre
      catt # chromecast
      digikam # photos
      feh # image viewer
      kdePackages.kdenlive
      mpc
      mpv
      # ncmpcpp
      nicotine-plus # music
      picard # music metadata
      playerctl # media controls
      rhythmbox # music
      sonixd # subsonic music client
      quodlibet # music
      ueberzug # allows images on terminal
      # vlc
      yt-dlp # youtube downloader

      # communication
      # cinny-desktop  # matrix client
      # gajim  # xmpp client
      # signal-desktop
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
      # gnomeExtensions.yakuake
      libsForQt5.qtstyleplugin-kvantum
      nightfox-gtk-theme
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
      bluetui # bluetooth
      dig
      gvfs
      seahorse # keyring
      magic-wormhole # fileshare
      lsof
      lua51Packages.luarocks # for nvim
      # opensnitch
      # opensnitch-ui
      proxychains
      redshift
      ripgrep
      sensible-utils
      udisks2
      udiskie # for automounting usb drives when plugged in
      # wine64
      # wineWowPackages.full
      # winetricks
      wireguard-tools
      # xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      remmina # remote desktop
    ]
    ++ unstablePackages);
}

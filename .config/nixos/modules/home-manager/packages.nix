{
  config,
  pkgs,
  unstablePkgs,
  inputs,
  ...
}:
  let
    packages = with pkgs; [
      # fonts
      nerd-fonts
      nerd-fonts-fira-mono
      nerd-fonts-ubuntu
      nerd-fonts-jetbrains-mono
      nerd-fonts-fira-code
      cascadia-code
      fira
      fira-code
      fira-mono
      iosevka
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      ubuntu_font_family

      # blockchain
      # electrum
      ledger_agent
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
      tectonic  # pdf engine for pandoc
      nextcloud-client
      zathura

      # media
      calibre
      catt  # chromecast
      digikam  # photos
      feh  # image viewer
      kdePackages.kdenlive
      mpc-cli
      mpv
      # ncmpcpp
      nicotine-plus  # music
      picard  # music metadata
      playerctl # media controls
      rhythmbox  # music
      sonixd  # subsonic music client
      quodlibet  # music
      ueberzug # allows images on terminal
      # vlc
      yt-dlp  # youtube downloader

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
      seahorse  # keyring
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
      wine64
      winetricks
      # xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    unstablePackages = with unstablePkgs; [
	sparrow
	simplex-chat-desktop
	hyprlock
    ];
    home.packages = packages ++ unstablePackages;
  in
{
}

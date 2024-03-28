{ pkgs, ... }:

{
  environment = {
	  systemPackages = with pkgs; [
	    # xfce
	    blueman
	    xfce.catfish
	    xfce.gigolo
	    xfce.orage
	    xfce.xfburn
	    xfce.xfce4-appfinder
	    xfce.xfce4-clipman-plugin
	    xfce.xfce4-cpugraph-plugin
	    xfce.xfce4-dict
	    xfce.xfce4-fsguard-plugin
	    xfce.xfce4-genmon-plugin
	    xfce.xfce4-netload-plugin
	    xfce.xfce4-panel
	    xfce.xfce4-pulseaudio-plugin
	    xfce.xfce4-systemload-plugin
	    xfce.xfce4-weather-plugin
	    xfce.xfce4-whiskermenu-plugin
	    xfce.xfce4-xkb-plugin
	    xorg.xev
	  ];
  };

  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };

  programs = {
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
  };

  security.pam.services.gdm.enableGnomeKeyring = true;

  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = false;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    xserver = {
      enable = true;
      excludePackages = with pkgs; [
        xterm
      ];
      desktopManager.xfce.enable = true;
      windowManager.qtile.enable = true;
    };
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
}

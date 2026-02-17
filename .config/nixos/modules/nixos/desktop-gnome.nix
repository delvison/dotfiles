{
  config,
  pkgs,
  ...
}: {
  # # As of 25.11
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # To disable installing GNOME's suite of applications
  # and only be left with GNOME shell.
  # services.gnome.core-apps.enable = false;
  # services.gnome.core-apps.enable = true;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [gnome-tour gnome-user-docs];

  # gnomeExtensions
  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.arc-menu
    gnomeExtensions.dash2dock-lite
    gnomeExtensions.media-controls
    gnomeExtensions.clipboard-history
    gnomeExtensions.ip-finder
    gnomeExtensions.proxy-switcher
    gnomeExtensions.user-themes-x
    gnomeExtensions.space-bar
    gnomeExtensions.switcher
    gnomeExtensions.caffeine

    everforest-gtk-theme
  ];

  # Ref: https://nixos.wiki/wiki/Remote_Desktop
  # Enable the GNOME RDP components
  services.gnome.gnome-remote-desktop.enable = false;

  # Ensure the service starts automatically at boot so the settings panel appears
  # systemd.services.gnome-remote-desktop = {
  #   wantedBy = ["graphical.target"];
  # };

  # Open the default RDP port (3389)
  # networking.firewall.allowedTCPPorts = [3389];

  # Disable autologin to avoid session conflicts
  services.displayManager.autoLogin.enable = false;
  services.getty.autologinUser = null;
}

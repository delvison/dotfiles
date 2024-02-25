{ config, pkgs, ... }:

{
  imports =
    [
      ../../modules/home-manager/packages.nix
    ];
  home.username = "npc";
  home.homeDirectory = "/home/npc";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
    "electron-24.8.6"
    "electron-25.9.0"
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
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.file = {
    ".gitconfig".text = ''
    [credential "https://gitea.donttrackme.xyz"]
      helper = "!f() { test \"$1\" = get && echo \"username=$(pass homelab/server/gitea/personal | grep login | awk '{print $2}')\npassword=$(pass homelab/server/gitea/personal | grep token | awk '{print $2}')\"; }; f"

    [credential "https://github.com"]
      helper = "!f() { test \"$1\" = get && echo \"username=$(pass github.com/personal | grep login | awk '{print $2}')\npassword=$(pass github.com/personal | grep api-key | awk '{print $2}')\"; }; f"
    '';

    # ".config/git-annex/autostart".text = ''
    #   ~/.electrum
    #   ~/.password-store
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    OBSIDIAN_USE_WAYLAND = "1"; 
  };

  # libvirt
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  # services.fusuma = {
  #   enable = true;
  #   extraPackages = with pkgs; [ xdotool ];
  #   settings = {
  #     threshold = { swipe = 0.1; };
  #     interval = { swipe = 0.7; };
  #     swipe = {
  #       "3" = {
  #         left = {
  #           # GNOME: Switch to left workspace
  #           command = "xdotool key ctrl+alt+Left";
  #         };
  #         right = {
  #           # GNOME: Switch to right workspace
  #           command = "xdotool key ctrl+alt+Right";
  #         };
  #       };
  #     };
  #   };
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

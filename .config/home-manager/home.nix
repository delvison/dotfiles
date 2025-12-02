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

{ config, lib, pkgs, ... }:

{
  options = {};
  config = {
    users = {
      defaultUserShell = pkgs.zsh;
      groups.plugdev = {};
      users.npc = {
        isNormalUser = true;
        description = "npc";
        extraGroups = [ 
          "networkmanager" 
          "wheel"
          "libvirtd"
          "plugdev"
          "docker"
          "keyd"
        ];
        packages = with pkgs; [];
      };
    };
  };
}

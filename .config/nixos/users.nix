{ config, lib, pkgs, ... }:

{
  options = {};
  config = {
    users.defaultUserShell = pkgs.zsh;
    users.groups.plugdev = {};
    users.users.npc = {
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
      packages = with pkgs; [
      ];
    };
  };
}

{ config, lib, pkgs, ... }:

{
  # print out diffs on nix rebuild
  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff \
        /run/current-system "$systemConfig"
      '';
  };

  environment.systemPackages = with pkgs;
    [
      unstable.python3
      # https://discourse.nixos.org/t/virt-manager-cannot-find-virtiofsd/26752
      firefox-esr
      pinentry-curses
      vim
      virtiofsd
      virt-manager
      xdg-utils
    ];
}

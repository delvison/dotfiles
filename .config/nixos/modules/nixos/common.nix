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
      busybox
      unstable.python3
      firefox-esr
      pinentry-curses
      vim
      # https://discourse.nixos.org/t/virt-manager-cannot-find-virtiofsd/26752
      virtiofsd
      virt-manager
      xdg-utils
    ];
}

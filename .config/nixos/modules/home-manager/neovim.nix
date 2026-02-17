{
  config,
  pkgs,
  lib,
  flake-inputs,
  ...
}: {
  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ps.magick];
    extraPackages = [pkgs.imagemagick];
  };
}

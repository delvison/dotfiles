# path: /etc/nixos/keyboard.nix
# info: config to allow for CAPS+hjkl navigation

{ config, lib, pkgs, ... }:
let
    myCustomLayout = pkgs.writeText "xkb-layout" ''
      ! remove Lock = Caps_Lock
      ! keycode 66 =
      keycode 66 = Mode_switch
      keysym h = h H Left
      keysym l = l L Right
      keysym k = k K Up
      keysym j = j J Down
      keysym u = u U Prior
      keysym i = i I Home
      keysym o = o O End
      keysym p = p P Next
    '';
in {
  services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomLayout}";

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main = {
            capslock = "layer(capslock)";
          };
          capslock = {
            h = "left";
            l = "right";
            k = "up";
            j = "down";
            u = "prior";
            i = "home";
            o = "end";
            p = "next";
          };
        };
      };
    };
  };
}

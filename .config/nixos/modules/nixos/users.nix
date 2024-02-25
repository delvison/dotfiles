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
        packages = with pkgs; [
          # pass
          passExtensions.pass-audit
          passExtensions.pass-genphrase
          passExtensions.pass-import
          passExtensions.pass-otp
          passExtensions.pass-tomb
          passExtensions.pass-update
          (pass.withExtensions (ext: with ext; [ pass-audit pass-otp pass-import pass-genphrase pass-update pass-tomb]))
          pass

          # utils
          curl
          flatpak
          fprintd
          fusuma
          fzf
          gnome.gnome-software
          htop
          plasma5Packages.plasma-thunderbolt
          power-profiles-daemon
          restic
          socat
          tmux
          torsocks
          usbutils
          wget
          xdotool
          zsh

          # security
          age
          librewolf
          openssh
          openvpn
          sshfs
          tor-browser-bundle-bin
          mullvad-browser
        ];
      };
    };
  };
}

{ ... }:

{
  networking = {
    networkmanager.enable = true;
    hostName = "fw13";
    nameservers = [
      "192.168.50.3"    # pi-hole
      "192.168.1.224"   # pi-hole
      "192.168.1.1"     # router
      "100.100.100.100" # https://tailscale.com/kb/1063/install-nixos/#using-magicdns
      "9.9.9.9"
    ];
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedTCPPorts = [
        22000 # syncthing
        443
        53317 # localsend 
      ];
      allowedUDPPorts = [
        22000 # syncthing
        21027 # syncthing
        53317 # localsend 
      ];
      allowedTCPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect
      ];
      allowedUDPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect
      ];
    };
  };
}

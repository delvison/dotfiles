# nix.nix
# block access to the NixOS cache CDN with an external firewall rule by blocking the fastly IP range 151.101.0.0/16.
{...}: {
  nix = {
    settings = {
      allowed-users = ["@wheel"];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    # Automatic Garbage Collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}

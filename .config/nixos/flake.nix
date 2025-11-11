{
  description = "Nixos config flake";

  inputs = {
    darkmatter.url = "gitlab:VandalByte/darkmatter-grub-theme";
    hyprland.url = "github:hyprwm/Hyprland";
    hypridle.url = "github:hyprwm/hypridle/?ref=v0.1.7";  # https://github.com/hyprwm/hypridle
    hyprlock.url = "github:hyprwm/hyprlock/?ref=v0.9.0";  # https://github.com/hyprwm/hyprlock/
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";  # https://github.com/gmodena/nix-flatpak
    musnix.url = "github:musnix/musnix";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    self, 
    nixpkgs, 
    nixpkgs-unstable, 
    darkmatter, 
    hypridle, 
    nix-flatpak,
    musnix,
    ... 
  }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      unstablePkgs = import nixpkgs-unstable {
        inherit system;
        config = { allowUnfree = true; };
      };
    in
  {
    nixosConfigurations = {
      fw13 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [ 
          ./hosts/fw13/configuration.nix
          darkmatter.nixosModule
          nix-flatpak.nixosModules.nix-flatpak
          inputs.musnix.nixosModules.musnix
        ];
      };
    };
  };
}

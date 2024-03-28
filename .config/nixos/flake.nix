{
  description = "Nixos config flake";

  inputs = {
    darkmatter.url = "gitlab:VandalByte/darkmatter-grub-theme";
    hyprland.url = "github:hyprwm/Hyprland";
    hypridle.url = "github:hyprwm/hypridle";
    hyprlock.url = "github:hyprwm/hyprlock";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.3.0";

    nixpkgs = {
      # url = "github:nixos/nixpkgs/nixos-unstable";
      url = "github:nixos/nixpkgs/nixos-23.11";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    self, 
    nixpkgs, 
    darkmatter, 
    hypridle, 
    nix-flatpak,
    ... 
  }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
      	fw13 = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            ./hosts/fw13/configuration.nix
            darkmatter.nixosModule
            nix-flatpak.nixosModules.nix-flatpak
          ];
        };
      };
    };
}

{
  description = "Nixos config flake";

  inputs = {
    darkmatter.url = "gitlab:VandalByte/darkmatter-grub-theme";
    hyprland.url = "github:hyprwm/Hyprland?ref=v0.40.0";
    hypridle.url = "github:hyprwm/hypridle/?ref=v0.1.2";
    hyprlock.url = "github:hyprwm/hyprlock/?ref=v0.3.0";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.3.0";

    nixpkgs = {
      # url = "github:nixos/nixpkgs/nixos-unstable";
      url = "github:nixos/nixpkgs/nixos-23.11";
    };

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
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

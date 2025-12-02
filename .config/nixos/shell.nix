{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    alejandra
    delta
    git
    home-manager
    just
    neovim
  ];
}

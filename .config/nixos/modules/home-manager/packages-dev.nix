{
  config,
  pkgs,
  ...
}:
  let
    unstable = import
      (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/68e06b5c7298cad3993b27cf60c67c80edbb3c2d)
      # reuse the current configuration
      { config = config.nixpkgs.config; };
  in
{
  home.packages = with pkgs; [
    ansible
    bats
    delta  # pager for git
    distrobox
    gh
    git
    git-annex
    git-remote-gcrypt
    glow  # markdown preview
    gnumake
    go
    gopls
    hadolint
    jq
    just
    neovim
    nodejs
    openssl
    pre-commit
    python3
    python311Packages.pip
    sops
    tree
    virt-manager
    vscode
    yq
  ];
}

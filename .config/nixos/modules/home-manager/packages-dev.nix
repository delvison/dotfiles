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
    # dev
    ansible
    bats
    delta  # pager for git
    distrobox
    gh
    git
    git-annex
    git-remote-gcrypt
    go
    gopls
    gnumake
    jq
    just
    neovim
    openssl
    python3
    python311Packages.pip
    sops
    tree
    vscode
    yq
    virt-manager
  ];
}

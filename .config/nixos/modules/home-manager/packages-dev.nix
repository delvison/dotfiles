{
  config,
  pkgs,
  unstablePkgs,
  inputs,
  ...
}:
  let
    packages = with pkgs; [
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
      tgpt  # chatgpt cli
      tree
      yq
    ];
    unstablePackages = with unstablePkgs; [
      vscode
    ];
    home.packages = packages ++ unstablePackages;
  in
{
}

{
  config,
  pkgs,
  unstablePkgs,
  inputs,
  ...
}: let
  unstablePackages = with unstablePkgs; [
    vscode
  ];
in {
  home.packages = with pkgs; ([
      ansible
      bats
      delta # pager for git
      distrobox
      gh
      git
      git-annex
      git-remote-gcrypt
      glow # markdown preview
      gnumake
      go
      gopls
      hadolint
      jq
      just
      lazygit
      markdown-oxide # https://github.com/Feel-ix-343/markdown-oxide
      # neovim
      nodejs
      opencode
      openssl
      pre-commit
      python3
      python311Packages.pip
      sops
      tgpt # chatgpt cli
      tree
      yq
    ]
    ++ unstablePackages);
}

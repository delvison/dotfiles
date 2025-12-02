{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.ssh.startAgent = false;

  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    age-plugin-yubikey
    gnupg
    libykclient
    libyubikey
    # pcsctools # 25.05 smartcard util
    pcsc-tools # smartcard util
    pcsclite # smartcard util
    yubico-pam
    yubico-piv-tool
    yubikey-agent
    yubikey-manager
    yubikey-personalization
    yubikey-touch-detector
  ];

  environment.shellInit = ''
    # gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

  services.udev.packages = with pkgs; [
    yubikey-personalization
  ];
}

{ config, pkgs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  # Fingerprintreader
  services.fprintd.enable = true;

  users.users.${username}.packages = with pkgs; [
    android-studio
    element-desktop
    qemu
    spotify
    thunderbird
    vscode
  ];
}


# Custom Settings for each user/pc that might be very individual. It only needs the import of ./hardware-configuration.nix as a bare minimum. 
{ config, pkgs, username, ... }:

{
  imports = [
    ./config.nix
    ./hardware-configuration.nix
    ./kanshi.nix
  ];

  secrets.enable = true;

  users.users.${username}.packages = with pkgs; [
    android-studio
    bitwarden
    element-desktop
    fwupd
    nextcloud-client
    onlyoffice-desktopeditors
    qemu
    signal-desktop
    simple-scan
    spotify
    texliveFull
    thunderbird
    vscode
  ];
  
  # Fingerprintreader
  #services.fprintd.enable = true;

  # Pin on Linux Version 6.6
  #boot.kernelPackages = pkgs.linuxPackages_6_6;
}


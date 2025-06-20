# Custom Settings for each user/pc that might be very individual. It only needs the import of ./hardware-configuration.nix as a bare minimum. 
{ config, pkgs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  
  # Fingerprintreader
  services.fprintd.enable = true;

  # Pin on Linux Version 6.6
  #boot.kernelPackages = pkgs.linuxPackages_6_6;

  users.users.${username}.packages = with pkgs; [
    android-studio
    docker_28
    element-desktop
    fwupd
    nextcloud-client
    qemu
    spotify
    thunderbird
    vscode
  ];
}


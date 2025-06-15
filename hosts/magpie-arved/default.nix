{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  # Fingerprintreader
  services.fprintd.enable = true;
}


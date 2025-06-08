{ config, pkgs, ... }:

{
  imports = [
    ../../home/desktop.nix
    ../../home/niri/default.nix
    ../../home/waybar/default.nix
  ];
  home.username = "arved";
  home.homeDirectory = "/home/arved";

  home.packages = with pkgs; [
    thunderbird
  ];

  services.mako = {
    enable = true;
    defaultTimeout = 5000;
  };

  home.stateVersion = "25.05";
}


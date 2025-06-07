{ config, pkgs, ... }:

{
  imports = [
    ../../home/desktop.nix
    ../../home/niri/default.nix
  ];
  home.username = "arved";
  home.homeDirectory = "/home/arved";

  home.packages = with pkgs; [
    thunderbird
  ];

  home.stateVersion = "25.05";
}


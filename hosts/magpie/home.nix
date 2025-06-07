{ config, pkgs, ... }:

{
  home.username = "arved";
  home.homeDirectory = "/home/arved";

  home.packages = with pkgs; [
    thunderbird
  ];

  home.stateVersion = "25.05";
}


{ config, pkgs, lib, ... }:

let
  mySettings = import ./waybar-config.nix;
in
{
  programs.waybar = {
    enable = true;
    settings = lib.mkForce [ mySettings ];
    style = builtins.readFile ./waybar-style.css;
  };
}

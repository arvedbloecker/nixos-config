# Ranger.nix - Mit eog als Standard-Bildviewer
{ pkgs, username, ... }:
{
  environment.systemPackages = [
    pkgs.ranger
    pkgs.w3m
  ];
}

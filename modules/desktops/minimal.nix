# A minimal system config that forms the base for all other systems.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    extraOptions = "download-buffer-size = 1073741824"; # 1 GiB
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  programs.fish.enable = true;
  environment.variables.EDITOR = "hx";
}

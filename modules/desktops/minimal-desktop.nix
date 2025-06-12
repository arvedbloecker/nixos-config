# Stuff I want in every desktop system, regardless of the window manager
{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./minimal.nix
  ];

  config = {

    # Deep Sleep is more energy efficient
    boot.kernelParams = [
      "mem_sleep_default=deep"
    ];

    services.printing.enable = true;

    nixpkgs.config.allowUnfree = true;

    services.xserver = {
      enable = true;
      displayManager.startx.enable = true;
    };
  
    programs.firefox.enable = true;

    environment.systemPackages = with pkgs; [
      playerctl
      networkmanager_dmenu
      networkmanagerapplet
      pamixer
      brightnessctl
      cascadia-code
      ghostty
      fuzzel
      starship     
    ];
  };
}

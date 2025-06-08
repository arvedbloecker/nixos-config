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
    ../fonts.nix
  ];

  config = {

    networking.networkmanager.enable = true;

    services.printing.enable = true;

    nixpkgs.config.allowUnfree = true;

    services.xserver = {
      enable = true;
      displayManager.startx.enable = true;
    };
  
    services.xserver.xkb = {
      layout = "us";
      variant = "altgr-intl";
    };

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    programs.firefox.enable = true;
    environment.systemPackages = with pkgs; [
      playerctl
      networkmanager_dmenu
      pamixer
      brightnessctl
      cascadia-code
      ghostty
      starship
    ];
  };
}

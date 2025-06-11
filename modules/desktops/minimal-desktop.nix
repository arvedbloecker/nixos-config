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

    # Deep Sleep is more energy efficient
    boot.kernelParams = [
      "mem_sleep_default=deep"
    ];

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

    security.pam.services.swaylock = {
      text = ''
        auth include login
        account include login
        password include login
        session include login
      '';
    };

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

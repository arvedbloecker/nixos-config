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

    security.pam.services.swaylock = {
      text = ''
        auth  [success=1 default=ignore] pam_fprintd.so
        auth  sufficient pam_unix.so try_first_pass nullok
        auth  required pam_deny.so
        account include login
        password include login
        session include login
      '';
    };

    security.pam.services.gtklock = {
      text = ''
        auth     sufficient pam_fprintd.so
        auth     include login
        account  include login
        password include login
        session  include login
      '';
    };
    
    environment.systemPackages = with pkgs; [
      gtklock
      swaylock
      playerctl
      networkmanager_dmenu
      pamixer
      brightnessctl
      cascadia-code
      ghostty
      fuzzel
      starship
    ];
  };
}

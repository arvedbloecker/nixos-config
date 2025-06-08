{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktops/gnome.nix # Choose only 1 from desktops
    ../../modules/niri.nix
    ../../modules/tlp.nix
  ];

  networking.hostName = "magpie";
  networking.networkmanager.enable = true;

  services.printing.enable = true;

  # Fingerprintreader
  services.fprintd.enable = true;
  
  users.users.arved = {
    isNormalUser = true;
    description = "Arved Bloecker";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
  };

  # Im Home-Manager oder Shell-Init:
  programs.fish.interactiveShellInit = ''
    if [ "$(tty)" = "/dev/tty1" ]; and ! pgrep -u $USER niri
      exec niri
    end
  '';

  home-manager.backupFileExtension = "backup";


  environment.systemPackages = with pkgs; [
    # Hier bei bedarf weitere Pakete
  ];
  system.stateVersion = "25.05";
}


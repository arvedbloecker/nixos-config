{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    #../../modules/desktops/gnome.nix # Choose only 1 from desktops
    ../../modules/desktops/custom-desktop.nix
    ../../modules/core
    ../../modules/niri.nix
    ../../modules/tlp.nix
  ];

  networking.hostName = "magpie";

  # Fingerprintreader
  services.fprintd.enable = true;

  users.users.arved = {
    isNormalUser = true;
    description = "Arved Bloecker";
    extraGroups = [
      "networkmanager"
      "wheel"
      "plugdev"
    ];
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
    element-desktop
  ];
  system.stateVersion = "25.05";
}


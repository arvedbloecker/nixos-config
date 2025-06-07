{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/minimal.nix
    ../../modules/gnome.nix
  ];

  networking.hostName = "magpie";
  networking.networkmanager.enable = true;

  # Keyboard Layout
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "altgr-intl";
  };

  services.printing.enable = true;

  # Fingerprintreader
  services.fprintd.enable = true;
  
  # Audio mit PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.arved = {
    isNormalUser = true;
    description = "Arved Bloecker";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Hier bei bedarf weitere Pakete
  ];
  system.stateVersion = "25.05";
}


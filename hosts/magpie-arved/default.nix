{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  # Fingerprintreader
  services.fprintd.enable = true;

  # Im Home-Manager oder Shell-Init:
  programs.fish.interactiveShellInit = ''
    if [ "$(tty)" = "/dev/tty1" ]; and ! pgrep -u $USER niri
      exec niri
    end
  '';
}


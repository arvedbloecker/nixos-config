# Gnome desktop config
{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./minimal-desktop.nix
  ];
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  programs.xwayland.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}

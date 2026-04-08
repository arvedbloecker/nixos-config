{ lib, config, ... }:
{
  options.modules.desktop = {
    enable = lib.mkEnableOption "Enable the desktop environment suite (Niri, GNOME, and KDE)";
  };

  imports = [
    ./cursor.nix
    ./fonts.nix
    ./gtk.nix
    ./opengl.nix
    ./qt.nix
    ./xdg-desktop-portal.nix

    ./niri
    ./gnome
    ./kde
  ];
}

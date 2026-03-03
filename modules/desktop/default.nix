{ lib, config, ... }:
{
  options.modules.desktop = {
    niri.enable = lib.mkEnableOption "Enable niri Wayland compositor";
    gnome.enable = lib.mkEnableOption "Enable GNOME with PaperWM";
    plasma.enable = lib.mkEnableOption "Enable KDE Plasma 6 Desktop";
  };

  config.assertions = [
    {
      assertion = (lib.count (x: x) [
        config.modules.desktop.niri.enable
        config.modules.desktop.gnome.enable
        config.modules.desktop.plasma.enable
      ]) <= 1;
      message = "Only one desktop environment can be enabled at a time.";
    }
  ];

  imports = [
    ./cursor.nix
    ./fonts.nix
    ./gtk.nix
    ./opengl.nix
    ./plasma.nix
    ./qt.nix

    ./niri
    ./gnome
  ];
}

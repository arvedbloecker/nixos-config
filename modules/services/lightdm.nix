{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.modules.displayManager.lightdm.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config.services.xserver.displayManager.lightdm =
    lib.mkIf (config.modules.displayManager.lightdm.enable)
      {
        enable = true;
        background = ../../pkgs/wallpaper/RedBlueMountain.png;

        greeters.gtk = {
          enable = true;
          theme.package = pkgs.catppuccin-gtk.override {
            variant = "mocha";
            accents = [ "blue" ];
          };
          theme.name = "Catppuccin-Mocha-Blue";

          iconTheme.package = pkgs.catppuccin-papirus-folders.override {
            flavor = "mocha";
            accent = "blue";
          };
          iconTheme.name = "Papirus-Dark";

          cursorTheme.package = pkgs.catppuccin-cursors.mochaDark;
          cursorTheme.name = "Catppuccin-Mocha-Dark";
          cursorTheme.size = 24;

          indicators = [ ];
        };
      };
}

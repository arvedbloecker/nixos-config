
{
  pkgs,
  username,
  ...
}:
{
  home-manager.users.${username} =
    { config, ... }:
    {
      gtk = {
        enable = true;
        iconTheme.name = "Adwaita";
        iconTheme.package = pkgs.adwaita-icon-theme;
        # theme.name = "Graphite-Dark";
        # theme.package = pkgs.graphite-gtk-theme.override { tweaks = [ "black" ]; };
      };
    };
}

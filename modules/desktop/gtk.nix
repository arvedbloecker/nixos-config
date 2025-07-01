
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
        theme.name = "Everforest";
        theme.package = pkgs.everforest-gtk-theme;
      };
    };
}

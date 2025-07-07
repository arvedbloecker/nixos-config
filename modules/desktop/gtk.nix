
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
        #iconTheme.name = "Adwaita";
        #iconTheme.package = pkgs.adwaita-icon-theme;
        theme.name = "Gruvbox-Dark";
        theme.package = pkgs.gruvbox-gtk-theme;

        iconTheme.name = "Gruvbox-Plus-Dark";
        iconTheme.package = pkgs.gruvbox-plus-icons;
      };
    };
  }


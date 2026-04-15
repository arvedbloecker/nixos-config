{
  pkgs,
  username,
  ...
}:
{
  home-manager.users.${username} =
    { config, ... }:
    {
      # gtk = {
      #   enable = true;
      #   theme.name = "Gruvbox-Dark";
      #   theme.package = pkgs.gruvbox-gtk-theme;

      #   iconTheme.name = "Gruvbox-Plus-Dark";
      #   iconTheme.package = pkgs.gruvbox-plus-icons;
      # };
      gtk = {
        enable = true;
        theme.name = "Arc-Dark";
        theme.package = pkgs.arc-theme;

        iconTheme.name = "Adwaita";
        iconTheme.package = pkgs.adwaita-icon-theme;
      };
    };
}

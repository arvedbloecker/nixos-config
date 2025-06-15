{
  pkgs,
  username,
  ...
}:
{
  home-manager.users.${username} =
    {
      config, ...
    }:
    {
      home.pointerCursor = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        size = 18;
        gtk.enable = true;
      };
    };
}

# BTOP is a modern system monitor
{ pkgs, username, ... }:

{
  home-manager.users.${username} = { config, ... }: {

    programs.btop = {
      enable = true;
      settings = {
        # Name der .theme-Datei im share-Ordner (oder ~/.config/btop/themes)
        color_theme      = "onedark.theme";
        theme_background = false;
        truecolor        = true;
      };
    };

  };
}


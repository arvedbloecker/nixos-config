# BTOP is a modern system monitor
{ username, ... }:

{
  home-manager.users.${username} = { config, ... }: {

    programs.btop = {
      enable = true;
      settings = {
        # Name of the .theme-Datei in the share-Directory (or ~/.config/btop/themes)
        color_theme      = "onedark.theme";
        theme_background = false;
        truecolor        = true;
      };
    };

  };
}


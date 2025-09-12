# BTOP is a modern system monitor
{ pkgs, username, ... }:

{
  home-manager.users.${username} = { config, ... }: {

    programs.btop = {
      enable = true;

      # Paket wählen (optional, Standard ist pkgs.btop)
      # package = pkgs.btop;

      settings = {
        # Name der .theme-Datei im share-Ordner (oder ~/.config/btop/themes)
        color_theme      = "gruvbox_dark_v2.theme";
        # Hintergrund aus der Theme-Datei verwenden
        theme_background = true;
        # 24-Bit-TruColor nutzen (Default: true)
        truecolor        = true;
        # Weitere Optionen sind möglich, z.B.:
        # force_tty       = false;
        # update_ms       = 2000;
      };
    };

  };
}


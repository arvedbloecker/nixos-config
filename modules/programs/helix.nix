# Helix is a Vim-Like texteditor
{ username, ... }:

{
  home-manager.users.${username} = { config, ... }: {

    programs.helix = {
      enable = true;

      # Wir setzen hier unser eigenes Theme als Standard
      settings = {
        theme = "gruvbox";
        editor.soft-wrap = {
          enable   = true;
          max-wrap = 25;
        };
      };

      # Deine bestehende Spracheinstellungen
      languages = {
        languages = [
          {
            name        = "nix";
            formatter   = { command = "nixfmt"; };
            auto-format = true;
          }
        ];
      };

      # Define a custom Theme
      themes = {
        everforest_dark_custom = {
          inherits = "everforest_dark";  # Extend the built-in Dark Medium Theme :contentReference[oaicite:0]{index=0}

          "ui.background"   = { bg = "bg_dim";      };   # #232a2e wie Kitty background
          "ui.selection"    = { bg = "bg0";         };   # #2d353b wie Kitty selection_background
          "markup.link.url" = { fg = "aqua"; underline = { style = "line"; }; };  # #83c092 wie Kitty url_color
          "ui.cursor"       = { fg = "bg_dim"; bg = "red"; };  # fg #232a2e, bg #e67e80 wie Kitty cursor
        };
      };
    };

  };
}

# Helix is a Vim-Like texteditor
{ username, ... }:

{
  home-manager.users.${username} = { config, ... }: {

    programs.helix = {
      enable = true;

      settings = {
        theme = "ayu_mirage_transparent";
        editor.soft-wrap = {
          enable   = true;
          max-wrap = 25;
        };
      };

      languages = {
        languages = [
          {
            name        = "nix";
            formatter   = { command = "nixfmt"; };
            auto-format = true;
          }
        ];
      };

      themes = {
        ayu_mirage_transparent = {
          "inherits" = "ayu_mirage";
          "ui.background" = {};
        };
        ayu_light_transparent = {
          "inherits" = "ayu_light";
          "ui.background" = {};
        };
      };
    };
  };
}

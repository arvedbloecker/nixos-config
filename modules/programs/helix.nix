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
        # editor.indent-guides = {
        #   render = true;
        #   character = " ";
        #   skip-levels = 1;
        # };

        editor.whitespace = {
          render = "all";
          characters = { tab = "→"; space = "·"; };
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
          "ui.linenr" = "gray";
          "ui.linenr.selected" = "foreground";

          # "ui.selection" = { bg="#344c4d"; };
          "ui.whitespace" = { fg="gray"; };
          # "ui.selection" = { bg="#263f40"; };
          # "ui.selection" = { bg="#2a9d8f"; }; #Verdigris (Cyan-Like)
          "ui.selection" = { bg="#264563"; }; #Charcoal Blue
          # "ui.selection" = { bg="#3C6E71"; }; # Stormy Teal

        };
        ayu_light_transparent = {
          "inherits" = "ayu_light";
          "ui.background" = {};
        };
      };
    };
  };
}

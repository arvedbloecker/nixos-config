# Helix is a Vim-Like texteditor
{ username, ... }:

{
  home-manager.users.${username} = { config, ... }: {

    programs.helix = {
      enable = true;

      # Wir setzen hier unser eigenes Theme als Standard
      settings = {
        theme = "ayu_mirage";
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
    };
  };
}

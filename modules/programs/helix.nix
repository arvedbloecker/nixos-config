{
  username,
  ...
}:
{
  home-manager.users.${username} =
    {
      config,
      ...
    }:
    {
      programs.helix = {
        enable = true;
        settings = {
          theme = "catppuccin_mocha";

          editor.soft-wrap = {
            enable = true;
            max-wrap = 25;
          };
        };
        languages = {
          languages = [
            {
              name = "nix";
              formatter = {
                command = "nixfmt";
              };
              auto-format = true;
            }
          ];
        };
      };
    };
}

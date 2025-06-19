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
    programs.kitty = {
      enable = true;
      extraConfig = ''
        background #1e1e2e
      '';
    };
  };
}

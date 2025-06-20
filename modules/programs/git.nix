{
  pkgs,
  username,
  userDescription,
  ...
}:
{
  home-manaher.users.${username} =
  {
    config, ...
  }:
  {
    programs.git = {
      enable = true;
      userName = "${userDescription}";
      extraConfig = {
        core.editor = "hx";
      }
    };
  };
}

{
  pkgs,
  username,
  userDescription,
  userEmail,
  ...
}:
{
  home-manager.users.${username} =
  {
    config, ...
  }:
  {
    programs.git = {
      enable = true;
      userName = userDescription;
      userEmail = userEmail;
      extraConfig = {
        core.editor = "${pkgs.helix}/bin/hx";
      };
    };
  };
}

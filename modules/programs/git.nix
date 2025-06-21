{
  pkgs,
  username,
  gitUsername,
  gitEmail,
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
      userName = gitUsername;
      userEmail = gitEmail;
      extraConfig = {
        core.editor = "${pkgs.helix}/bin/hx";
      };
    };
  };
}

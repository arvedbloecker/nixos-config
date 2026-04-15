{
  config,
  username,
  ...
}:
{
  home-manager.users.${username}.programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "/home/${username}/.ssh/id_github";
      };
      "gitlab.com" = {
        hostname = "gitlab.com";
        identityFile = "/home/${username}/.ssh/id_gitlab";
      };
      "codeberg.org" = {
        hostname = "codeberg.org";
        identityFile = "/home/${username}/.ssh/id_codeberg";
      };
      "myserver" = {
        hostname = "1.2.3.4";
        user = "admin";
        identityFile = "/home/${username}/.ssh/id_server";
      };
    };
  };
}

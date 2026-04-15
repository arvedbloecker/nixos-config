{
  username, ...
}:
{
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "hm-backup";
  home-manager.users.${username} =
    { config, ... }:
    {
      home.stateVersion = "25.05";
    };
}

{
  pkgs,
  username,
  userDescription,
  ...
}:
{
  #users.defaultUserShell = pkgs.zsh; # Change to fish
  users.defaultUserShell = pkgs.fish; # Change to fish
  users.users.${username} = {
    isNormalUser = true;
    description = userDescription;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
    ];
  };
}

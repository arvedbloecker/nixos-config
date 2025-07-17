{
  pkgs, username, ...
}:
{
  programs.fish.enable = true;

  programs.direnv.enable = true;
  programs.direnv.silent = true;
}

# Setting for the shell
{
  pkgs, username, ...
}:
{
  programs.fish.enable = true;

  programs.direnv.enable = true;
  programs.direnv.silent = true;

  documentation.dev.enable = true; #Documentation
}

{
  pkgs, username, ...
}:
{
  programs.zsh.enable = true;
  programs.fish.enable = true;

  programs.direnv.enable = true;
}

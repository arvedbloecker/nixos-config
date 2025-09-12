# Ranger is a TUI Filemanager
{
  pkgs, ...
}:
{
  programs.ranger = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    python3Packages.pillow
  ];
}

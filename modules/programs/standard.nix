# Many other apps
{
  pkgs, ...
}:
{
  environment.systemPackages = with pkgs; [
     
    evince # Dokument Viewer
    nautilus # File Manager
    eog # Show Photos
  ];
}

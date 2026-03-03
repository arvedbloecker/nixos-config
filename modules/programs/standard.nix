# Many other apps
{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [

    papers # evince but modern
    # evince # Dokument Viewer
    nautilus # File Manager
    eog # Show Photos
  ];
}

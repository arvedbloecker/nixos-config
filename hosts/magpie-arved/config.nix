{
  username,
  ...
}:
{
  modules = {
    desktop.niri.enable = true;
    # desktop.gnome.enable = true;

    powerManagement.tlp.enable = true;
    # powerManagement.ppd.enable = true;
    powerManagement.autoCpuFreq.enable = true;

    services.storage.enable = true;
    # programs.udiskie.enable = true;
  };

  # Enable Sops and Sops-Connected Modules
  secrets.enable = true;
  sops = {
    gitConfig.enable = true;
  };
}

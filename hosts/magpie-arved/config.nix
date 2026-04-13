{
  username,
  ...
}:
{
  modules = {
    desktop.enable = true;

    powerManagement.profile = "tlp";

    hardware.lenovo-amd.enable = true;

    services.storage.enable = true;
    # programs.udiskie.enable = true;

    apps = {
      android-studio.enable = true;
      ausweisapp.enable = true;
      firefox.enable = true;
      mullvad.enable = true;
      vscode.enable = true;
      swaync.enable = true;
    };
  };

  # Enable Sops and Sops-Connected Modules
  secrets.enable = true;
  sops = {
    gitConfig.enable = true;
  };
}

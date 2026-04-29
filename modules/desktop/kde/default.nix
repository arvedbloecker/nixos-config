{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.modules.desktop.enable {
  services = {
    xserver.enable = true;
    desktopManager.plasma6.enable = true;
  };


  environment.systemPackages = with pkgs.kdePackages; [
    plasma-workspace
    qtstyleplugin-kvantum
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
    elisa
    gwenview
    okular
    kate
    khelpcenter
    dolphin
    ark
    kcalc
    baloo
    discover
    krdp
    spectacle
    drkonqi
    plasma-welcome
    print-manager
    kwallet
  ];
}

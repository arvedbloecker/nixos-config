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

  security.pam.services.greetd.kwallet = {
    enable = true;
    package = pkgs.kdePackages.kwallet-pam;
  };

  environment.systemPackages = with pkgs.kdePackages; [
    plasma-workspace
    kwallet-pam
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
  ];
}

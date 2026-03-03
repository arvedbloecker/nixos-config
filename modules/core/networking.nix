{
  pkgs,
  ...
}:
{
  networking.networkmanager.enable = false;

  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    General = {
      EnableNetworkConfiguration = true;
    };
    Network = {
      NameResolvingService = "systemd";
    };
  };

  services.resolved.enable = true;
  environment.systemPackages = [
    pkgs.iwd
    pkgs.impala
    pkgs.bluetui
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}

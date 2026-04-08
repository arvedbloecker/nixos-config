{
  pkgs,
  ...
}:
{
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    General = {
      EnableNetworkConfiguration = false;
    };
    Network = {
      NameResolvingService = "systemd";
    };
  };

  services.resolved.enable = true;
  environment.systemPackages = [
    # pkgs.iwd
    # pkgs.impala
    pkgs.bluetui
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}

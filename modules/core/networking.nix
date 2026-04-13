{
  pkgs,
  ...
}:
{
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
    wifi.powersave = false;
    settings = {
      connection = {
        "ipv4.forwarding" = 0;
        "ipv6.forwarding" = 0;
      };
      device = {
        "wifi.scan-rand-mac-address" = "no";
      };
    };
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

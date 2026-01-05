{
  pkgs, ...
}:
{
  # Activates the NetworkManager-Daemon
  networking.networkmanager = {
    enable = true;

    packages = [
      pkgs.networkmanager-openconnect
    ];
  };

  # Activates Bluetooth-Support by starting the BlueZ-Service (bluetoothd)
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}

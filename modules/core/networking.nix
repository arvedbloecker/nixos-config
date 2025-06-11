{
  # Activates the NetworkManager-Daemon
  networking.networkmanager = {
    enable = true;
  };

  # Activates Bluetooth-Support by starting the BlueZ-Service (bluetoothd)
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}

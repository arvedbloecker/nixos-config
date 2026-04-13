{
  ...
}:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "amd_pstate=active"
    "rtc_cmos.use_acpi_alarm=1"
    "ath11k_pci.disable_aspm=1"
    # "quiet"
    # "loglevel=3"
    # "systemd.show_status=auto" # or false
    # "rd.systemd.show_status=false"
    # "rd.udev.log_level=3"
    # "udev.log_priority=3"
  ];
}

{ config, lib, pkgs, ... }:
let
  cfg = config.modules.hardware.lenovo-amd;
in
{
  options.modules.hardware.lenovo-amd = {
    enable = lib.mkEnableOption "Enable hardware-specific optimizations for Lenovo AMD laptops";
  };

  config = lib.mkIf cfg.enable {
    boot.kernelParams = [
      "amdgpu.abmlevel=0"
      "rtc_cmos.use_acpi_alarm=1"
    ];

    # Disable certain wakeup devices that cause accidental wakeups on Lenovo ThinkPads
    systemd.services.disable-wakeup-devices = {
      description = "Disable problematic wakeup devices";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        # Use simple bash loop for robustness
        ExecStart = "${pkgs.bash}/bin/sh -c 'for dev in XHC0 XHC1 XHC2 XHC3 XHC4; do if grep -q \"$dev.*enabled\" /proc/acpi/wakeup; then echo \"$dev\" > /proc/acpi/wakeup; fi; done'";
        RemainAfterExit = "yes";
      };
    };
  };
}

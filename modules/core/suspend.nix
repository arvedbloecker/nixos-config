{ pkgs, ... }:
{
  # Disable certain wakeup devices that cause accidental wakeups on Lenovo ThinkPads
  # Check current status with `cat /proc/acpi/wakeup`
  systemd.services.disable-wakeup-devices = {
    description = "Disable problematic wakeup devices";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        # Disable USB wakeup (XHC0-4) to prevent accidental wakeups from peripherals
        ''${pkgs.bash}/bin/sh -c 'for dev in XHC0 XHC1 XHC2 XHC3 XHC4; do if grep -q "$dev.*enabled" /proc/acpi/wakeup; then echo "$dev" > /proc/acpi/wakeup; fi; done' ''
      ];
      RemainAfterExit = "yes";
    };
  };
}

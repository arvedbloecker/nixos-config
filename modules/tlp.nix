{ config, pkgs, ... }:

{
  # Aktiviere TLP
  services.tlp = {
    enable = true;

    # Gerätetyp
    settings = {

      # General
      TLP_ENABLE = 1;
      TLP_PERSISTENT_DEFAULT = 0;

      # CPU Settings
      CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 30;

      # Platform Profile
      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # Battery charge treshholds
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;

      # PCIe, USB, Disk
      PCIE_ASPM_ON_AC = "powersave";
      PCIE_ASPM_ON_BAT = "powersave";

      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth";

      SATA_LINKPWR_ON_AC = "med_power_with_dipm";
      SATA_LINKPWR_ON_BAT = "med_power_with_dipm";

      SOUND_POWER_SAVE_ON_AC = 1;
      SOUND_POWER_SAVE_ON_BAT = 1;

      # AMD GPU Power Saving
      RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
      RADEON_DPM_PERF_LEVEL_ON_BAT = "low";
      RADEON_POWER_PROFILE_ON_BAT = "low";

      # Runtime Power Management
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
    };
  };


  # Deaktiviert den Power-Daemon, da ja jetzt tlp lauft
  services.power-profiles-daemon.enable = false;

  # Systemabhängige Zusatzpakete
  environment.systemPackages = with pkgs; [ tlp ];
}


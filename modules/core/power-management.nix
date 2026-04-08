{
  config,
  lib,
  pkgs,
  ...
}:

{

  options.modules.powerManagement = {
    tlp.enable = lib.mkEnableOption "enable tlp";
    ppd.enable = lib.mkEnableOption "enable power-profiles-daemon";
    autoCpuFreq.enable = lib.mkEnableOption "enable auto-cpufreq";
  };

  config = {

    services.tlp = lib.mkIf (config.modules.powerManagement.tlp.enable) {
      enable = true;
      settings = {
        TLP_ENABLE = 1;
        CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        # PCIe power management
        # "on" on AC avoids latency spikes from devices waking up
        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";
        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersave";

        # Wi-Fi: let iwd manage its own power saving — TLP interfering here
        # causes latency spikes and slow throughput with the iwd backend
        WIFI_PWR_ON_AC = "off";
        WIFI_PWR_ON_BAT = "off";

        USB_AUTOSUSPEND = 1;
        USB_EXCLUDE_AUDIO = 1;
        SOUND_POWER_SAVE_ON_BAT = 1;
        SOUND_POWER_SAVE_CONTROLLER = 1;

        # P14s uses amdgpu driver, not radeon — RADEON_DPM_* is a no-op here
        # AMD GPU power is managed via PLATFORM_PROFILE instead
        PLATFORM_PROFILE_ON_AC = "balanced";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 85;
      };
    };

    services.power-profiles-daemon.enable = config.modules.powerManagement.ppd.enable;

    environment.systemPackages =
      with pkgs;
      [
        tlp
      ]
      ++ lib.optionals config.modules.powerManagement.autoCpuFreq.enable [
        auto-cpufreq
      ];

    systemd.services.auto-cpufreq = lib.mkIf config.modules.powerManagement.autoCpuFreq.enable {
      description = "auto-cpufreq daemon";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.auto-cpufreq}/bin/auto-cpufreq --daemon";
        Restart = "on-failure";
      };
    };
  };

}

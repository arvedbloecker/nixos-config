{ config, lib, pkgs, ... }:

{

  options.modules.powerManagement = {
    tlp.enable        = lib.mkEnableOption "enable tlp";
    ppd.enable        = lib.mkEnableOption "enable power-profiles-daemon";
    autoCpuFreq.enable = lib.mkEnableOption "enable auto-cpufreq";
  };

  config = {

    # — TLP —
    services.tlp = lib.mkIf (config.modules.powerManagement.tlp.enable) {
      enable = true;
      settings = {
        TLP_ENABLE                        = 1;
        CPU_SCALING_GOVERNOR_ON_AC        = "schedutil";
        CPU_SCALING_GOVERNOR_ON_BAT       = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC      = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT     = "power";
        RUNTIME_PM_ON_BAT                 = "auto";
        PCIE_ASPM_ON_AC                   = "default";
        PCIE_ASPM_ON_BAT                  = "powersave";
        USB_AUTOSUSPEND                   = 1;
        USB_EXCLUDE_AUDIO                 = 1;
        SOUND_POWER_SAVE_ON_BAT           = 1;
        SOUND_POWER_SAVE_CONTROLLER       = 1;
        SATA_LINKPWR_ON_BAT               = "min_power";
        WIFI_PWR_ON_BAR                   = 5;
        RADEON_DPM_PERF_LEVEL_ON_BAT      = "low";
        PLATFORM_PROFILE_ON_AC            = "balanced";
        PLATFORM_PROFILE_ON_BAT           = "low-power";
        START_CHARGE_THRESH_BAT0          = 75;
        STOP_CHARGE_THRESH_BAT0           = 85;
      };
    };

    # — power-profiles-daemon —
    services.power-profiles-daemon.enable = config.modules.powerManagement.ppd.enable;

    # — Paket-Liste —
    environment.systemPackages = with pkgs; [
      tlp
    ] ++ lib.optionals config.modules.powerManagement.autoCpuFreq.enable [
      auto-cpufreq
    ];

    # — auto-cpufreq als systemd-Service —
    systemd.services.auto-cpufreq = lib.mkIf config.modules.powerManagement.autoCpuFreq.enable {
      description = "auto-cpufreq daemon";
      wantedBy   = [ "multi-user.target" ];
      serviceConfig = {
        Type      = "simple";
        ExecStart = "${pkgs.auto-cpufreq}/bin/auto-cpufreq --daemon";
        Restart   = "on-failure";
      };
    };
  };

}

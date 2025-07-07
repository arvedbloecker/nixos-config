{ config, lib, pkgs, ... }:

{

  options.modules.powerManagement = {
    # Default is false
    tlp.enable = lib.mkEnableOption "enable tlp"; 
    ppd.enable = lib.mkEnableOption "enable power-profiles-daemon";
  };

  config = {
    services.tlp = lib.mkIf (config.modules.powerManagement.tlp.enable){
      
      # Aktiviere TLP
      enable = true;

      # Gerätetyp
      settings = {

        # General
        TLP_ENABLE = 1;

        # CPU Settings
        CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        RUNTIME_PM_ON_BAT = "auto";
        PCIE_ASPM_ON_BAT = "powersave";

        USB_AUTOSUSPEND = 1;
        USB_EXCLUDE_AUDIO = 1;

        SOUND_POWER_SAVE_ON_BAT = 1;
        SOUND_POWER_SAVE_CONTROLLER = 1;

        SATA_LINKPWR_ON_BAR = "min_power";

        WIFI_PWR_ON_BAR = 5;

        RADEON_DPM_PERF_LEVEL_ON_BAT = "low";

        # Platform Profile
        PLATFORM_PROFILE_ON_AC = "balanced";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        # Battery charge treshholds
        START_CHARGE_THRESH_BAT0 = 50;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };

    };

    services.power-profiles-daemon.enable = config.modules.powerManagement.ppd.enable;
    
    # Systemabhängige Zusatzpakete
    environment.systemPackages = with pkgs; [ tlp ];
  };

}


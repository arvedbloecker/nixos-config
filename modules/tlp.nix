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

      # Platform Profile
      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # Battery charge treshholds
      START_CHARGE_THRESH_BAT0 = 50;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };


  # Deaktiviert den Power-Daemon, da ja jetzt tlp lauft
  services.power-profiles-daemon.enable = false;

  # Systemabhängige Zusatzpakete
  environment.systemPackages = with pkgs; [ tlp ];
}


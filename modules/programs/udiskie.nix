{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.services.storage;
in {
  options.modules.services.storage = {
    enable = mkEnableOption "Enable USB automounting and storage services";
  };

  config = mkIf cfg.enable {
    # System services für USB-Geräte
    services = {
      udisks2.enable = true;
      gvfs.enable = true;
    };

    # Polkit-Berechtigungen für USB-Mounting ohne sudo
    security.polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
               action.id == "org.freedesktop.udisks2.filesystem-mount" ||
               action.id == "org.freedesktop.udisks2.encrypted-unlock-system" ||
               action.id == "org.freedesktop.udisks2.encrypted-unlock") &&
              subject.isInGroup("wheel")) {
            return polkit.Result.YES;
          }
        });
      '';
    };

    # Pakete für verschiedene Dateisysteme
    environment.systemPackages = with pkgs; [
      udiskie
      udisks
      gvfs
      ntfs3g      # Windows NTFS
      exfat       # exFAT
      dosfstools  # FAT32
    ];
  };
}


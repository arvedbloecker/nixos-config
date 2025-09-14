{
  config,
  lib,
  pkgs,
  username,
  ...
}:
with lib; let
  cfg = config.modules.services.storage;
in {
  options.modules.services.storage = {
    enable = mkEnableOption "Enable USB automounting and storage services";
    
    udiskie = {
      notify = mkOption {
        type = types.bool;
        default = true;
        description = "Show desktop notifications for mount/unmount";
      };
      tray = mkOption {
        type = types.enum ["always" "auto" "never"];
        default = "auto";
        description = "When to show system tray icon";
      };
    };
  };

  config = mkIf cfg.enable {
    services = {
      udisks2.enable = true;
      gvfs.enable = true;
    };

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

    environment.systemPackages = with pkgs; [
      udiskie
      udisks
      gvfs
      ntfs3g      # Windows NTFS
      exfat       # exFAT
      dosfstools  # FAT32
    ];

    home-manager.users.${username} = {
      services.udiskie = {
        enable = true;
        automount = true;
        notify = cfg.udiskie.notify;
        tray = cfg.udiskie.tray;
        
        settings = {
          program_options = {
            file_manager = "${pkgs.ranger}/bin/ranger";
          };
        };
      };
    };
  };
}

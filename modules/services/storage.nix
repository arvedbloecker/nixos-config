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
    
    udiskie = {
      enable = mkEnableOption "Enable udiskie automount daemon" // {default = cfg.enable;};
      notify = mkBoolOpt true "Show desktop notifications for mount/unmount";
      tray = mkOption {
        type = types.enum ["always" "auto" "never" "smart"];
        default = "smart";
        description = "When to show system tray icon";
      };
    };
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

    environment.systemPackages = with pkgs; [
      udiskie
      udisks
      gvfs
      ntfs3g      # Windows NTFS
      exfat       # exFAT
      dosfstools  # FAT32
    ];

    # Home Manager udiskie configuration
    home-manager.users = lib.genAttrs (builtins.attrNames config.users.users) (username: {
      services.udiskie = mkIf cfg.udiskie.enable {
        enable = true;
        automount = true;
        notify = cfg.udiskie.notify;
        tray = cfg.udiskie.tray;
        
        settings = {
          program_options = {
            # Ranger as Filemanger
            file_manager = "${pkgs.ranger}/bin/ranger";
          };
        };
      };
    });
  };
}


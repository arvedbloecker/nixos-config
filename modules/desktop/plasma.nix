{ config, lib, ... }:
{
  config = lib.mkIf (config.modules.desktop.plasma.enable) {
    services = {
      xserver.enable = true;
      desktopManager.plasma6.enable = true;
    };
  };  
}

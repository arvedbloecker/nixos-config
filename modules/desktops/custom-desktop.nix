{ config, pkgs, ... }:

{
  imports = [
    ./minimal-desktop.nix
  ];

  

  # Activate LightDM
  services.xserver.displayManager.lightdm.enable = true;
  # Activate GTK-Greeter
  services.xserver.displayManager.lightdm.greeters.gtk.enable = true;

  # XWayland (falls nötig)
  programs.xwayland.enable = true;

  # Portals (i. E. Flatpak, Filepicker, etc.)
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };
}

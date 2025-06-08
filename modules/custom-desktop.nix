{ config, pkgs, ... }:

{
  # Installiere greetd + tuigreet (das ist der Login-Frontend)
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];

  # Aktiviere greetd
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'dbus-run-session niri'";
        user = "arved";
      };
    };
  };

  # Optional: XWayland (falls nötig)
  programs.xwayland.enable = true;

  # Portale (z. B. für Flatpak, Dateiöffner, etc.)
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };
}

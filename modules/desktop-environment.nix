# Minimalistisches Niri Desktop-Environment (systemweit)
{ config, lib, pkgs, ... }:

{
  imports = [
    ./niri.nix
  ];

  # Eingabemethoden (z. B. für verschiedene Layouts oder IMEs)
  i18n.inputMethod.enabled = "fcitx5";

  # Systemweite Pakete – reine Binary-Tools
  environment.systemPackages = with pkgs; [
    # GUI/CLI Tools
    blueman                   # Bluetooth GUI
    networkmanager_dmenu     # WLAN GUI
    pavucontrol              # Audio GUI
    brightnessctl            # Helligkeit per CLI
    wl-clipboard             # Wayland Copy/Paste
    cliphist                 # Clipboard-History Tool
    grim slurp               # Screenshots
    imv                      # Bildbetrachter
    swaybg                   # Wallpaper
    ghostty                  # Terminal
    wofi                     # Launcher
    kanshi                   # Monitor-Profilverwaltung
    xwayland-satellite       # DISPLAY=:0 Setzung
    mako                     # Benachrichtigungen (wird später im Home gestartet)
  ];

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Netzwerk
  networking.networkmanager.enable = true;

  # Portale (für Flatpak, electron, etc.)
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Fonts – optional, aber hilfreich
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fontconfig
  ];

  # DBus – meist ohnehin aktiv, hier zur Sicherheit
  services.dbus.enable = true;
}

{ pkgs, username, ... }:
let
  customThemekvc = ./../../pkgs/theme/Marge/Marge.kvconfig;
  customThemesvg = ./../../pkgs/theme/Marge/Marge.svg;
in
{
  environment.systemPackages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum # Qt5 apps
    kdePackages.qtstyleplugin-kvantum # Qt6 / KDE Plasma 6 (correct ABI)
    libsForQt5.qt5ct
    qt6Packages.qt6ct
  ];

  # Do NOT set qt.platformTheme or qt.style here — KDE manages its own
  # QT_QPA_PLATFORMTHEME=kde automatically. Setting qt5ct globally would
  # override that and break plasmashell. Per-session vars are set in niri.nix.

  home-manager.users.${username} =
    { ... }:
    {
      # No qt.platformTheme/style here either — would leak into KDE sessions
      # via ~/.profile. Theme files are sufficient; env vars are set per-session.

      xdg.configFile."Kvantum/MyCustomTheme/MyCustomTheme.kvconfig".source = customThemekvc;
      xdg.configFile."Kvantum/MyCustomTheme/MyCustomTheme.svg".source = customThemesvg;

      xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=MyCustomTheme
      '';

      xdg.configFile."qt5ct/qt5ct.conf".text = ''
        [General]
        style=kvantum
      '';

      xdg.configFile."qt6ct/qt6ct.conf".text = ''
        [General]
        style=kvantum
      '';
    };
}

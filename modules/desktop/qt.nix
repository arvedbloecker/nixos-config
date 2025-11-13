# Get the themes form https://store.kde.org/browse?cat=123&ord=latest
{ pkgs, username, ... }:

let
  # Define here the Theme, leave the rest untouched
  # Dont forget to add the theme to git
  customThemekvc = ./../../pkgs/theme/Marge/Marge.kvconfig;
  customThemesvg = ./../../pkgs/theme/Marge/Marge.svg;
in
{
  environment.systemPackages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6Packages.qtstyleplugin-kvantum
    qt6Packages.qt6ct
  ];

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  home-manager.users.${username} = { config, ... }: {
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };

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


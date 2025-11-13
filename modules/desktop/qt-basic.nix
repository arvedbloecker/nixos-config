# Find available Themes with:
# find /nix/store -path "*qtstyleplugin-kvantum*" -type f -name "*.kvconfig" | sed 's|.*Kvantum/||' | sed 's|/.*||' | sort -u
{ pkgs, username, ... }:

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

    xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=KvCyan
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

# Available Themes:
#
# Light:
# KvFlatLight
# KvCurvestLight
# KvMojaveLight
#
# Dark:
# KvArcDark
# KvGnomeDark
# KvAdaptaDark
# KvSimplicityDark
#
# Color:
# KvArc
# KvGnome
# KvMojave
# KvCyan
# KvYaru
# KvAmbiance


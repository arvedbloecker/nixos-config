{
  pkgs, username, ...
}:
{
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xkb";
    QT_STYLE_OVERRIDE = "kvantum";
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    gruvbox-kvantum
  ];
  
  home-manager.users.${username} = {
    config, pkgs, ...
  }:
  {
    xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Gruvbox-Dark-Blue
    '';
  };
}

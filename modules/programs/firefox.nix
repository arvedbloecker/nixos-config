# Firefox is a webbrowser
{lib, pkgs, username, ...}:
{

  home-manager.users.${username} = {
    config, ...
  }:
  {
    programs.firefox = {
      enable = true;

      profiles = {
          default = {
            settings = {
              "ui.textScaleFactor" = 100;
              "layout.css.devPixelsPerPx" = "1.0";
              "browser.display.os-zoom-behavior" = 1;
            };
          };
        };
      };
  };
}

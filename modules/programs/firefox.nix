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
            isDefault = true;
            settings = {
              "ui.textScaleFactor" = 100;
              "layout.css.devPixelsPerPx" = "1.0";
              "browser.display.os-zoom-behavior" = 1;
            };
            extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
              ublock-origin
              bitwarden
              privacy-badger
              sponsorblock
              consent-o-matic
            ];
          };
        };
      };
  };
}

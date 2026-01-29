{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  options.modules.services.hypridle.desktop = lib.mkEnableOption "hypridle desktop config";

  config =
    let
      hypridleSettings =
        if (!config.modules.services.hypridle.desktop) then
          # if false (standard) sets the hypridle on
          {
            general = {
              lock_cmd = "pidof hyprlock || niri msg action do-screen-transition && hyprlock --no-fade-in";
              before_sleep_cmd = "loginctl lock-session";
              after_sleep_cmd = "niri msg action power-on-monitors";
            };

            listener = [
              {
                timeout = 150;
                on-timeout = "brightnessctl -s set 10";
                on-resume = "brightnessctl -r";
              }
              {
                timeout = 150;
                on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
                on-resume = "brightnessctl -rd rgb:kbd_backlight";
              }
              {
                timeout = 300;
                on-timeout = "loginctl lock-session";
              }
              {
                timeout = 380;
                on-timeout = "niri msg action power-off-monitors";
                on-resume = "niri msg action power-on-monitors";
              }
              {
                timeout = 1800;
                on-timeout = "systemctl suspend";
              }
            ];
          }
        else
          # if true then nothing happens on inactivity (empty listener)
          {
            general = {
              lock_cmd = "pidof hyprlock || niri msg action do-screen-transition && hyprlock --no-fade-in";
              before_sleep_cmd = "loginctl lock-session";
              after_sleep_cmd = "niri msg action power-on-monitors";
            };

            listener = [ ];
          };
    in
    {
      environment.systemPackages = lib.mkIf (!config.modules.services.hypridle.desktop) [
        pkgs.brightnessctl
      ];

      home-manager.users.${username} =
        { config, ... }:
        {
          services.hypridle = {
            enable = true;
            settings = hypridleSettings;
          };
        };
    };
}

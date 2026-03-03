{
  config,
  pkgs,
  lib,
  username,
  ...
}:
lib.mkIf config.modules.desktop.niri.enable (
  let
    hypridleSettings = {
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
    };
  in
  {
    environment.systemPackages = [
      pkgs.brightnessctl
    ];

    home-manager.users.${username} =
      { ... }:
      {
        services.hypridle = {
          enable = true;
          settings = hypridleSettings;
        };
      };
  }
)

{
  config,
  pkgs,
  lib,
  username,
  ...
}:
let
  cfg = config.modules.apps.fnott;
  # Ayu Mirage Colors
  colors = {
    bg = "212733";
    fg = "d9d7ce";
    accent = "ffad66";
    red = "f28779";
    blue = "73d0ff";
    green = "d5ff80";
  };
in
{
  options.modules.apps.fnott = {
    enable = lib.mkEnableOption "fnott notification daemon";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = with pkgs; [
        fnott
        libnotify
        papirus-icon-theme
        mpv
        sound-theme-freedesktop
        (pkgs.writeShellScriptBin "fnott-toggle-dnd" ''
          if systemctl --user is-active --quiet fnott.service; then
            systemctl --user stop fnott.service
          else
            systemctl --user start fnott.service
          fi
        '')
      ];

      services.fnott = {
        enable = true;
        settings = {
          main = {
            anchor = "top-right";
            stacking-order = "top-down";
            min-width = 400;
            max-width = 500;
            edge-margin-vertical = 10;
            edge-margin-horizontal = 10;
            notification-margin = 8;
            icon-theme = "Papirus";
            max-icon-size = 48;
            selection-helper = "fuzzel -d";
            play-sound = "sh -c '${pkgs.mpv}/bin/mpv ${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/message.oga'";

            background = "${colors.bg}ff";
            border-color = "${colors.accent}ff";
            border-size = 2;
            padding-vertical = 12;
            padding-horizontal = 12;
            title-font = "JetBrainsMono Nerd Font:size=12";
            title-color = "${colors.fg}ff";
            summary-font = "JetBrainsMono Nerd Font:bold:size=11";
            summary-color = "${colors.fg}ff";
            body-font = "JetBrainsMono Nerd Font:size=11";
            body-color = "${colors.fg}ff";
          };

          low = {
            default-timeout = 0;
            background = "${colors.bg}ff";
            border-color = "${colors.blue}ff";
          };

          normal = {
            default-timeout = 0;
          };

          critical = {
            default-timeout = 0;
            background = "${colors.bg}ff";
            border-color = "${colors.red}ff";
          };
        };
      };

    };
  };
}

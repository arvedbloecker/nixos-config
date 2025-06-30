{  
  config,
  pkgs,
  username,
  ...
}:
let
  powerSettings =
    if (config.modules.powerManagement.ppd.enable) then
      ''
        ,
              "menu#power-profiles": {
                "label": "󱐋",
                "position": "left",
                "actions": [
                  {
                    "label": "󰓅 Performance",
                    "command": "sh -c 'cpupower-gui -p && powerprofilesctl set performance'"
                  },
                  {
                    "label": "󰾅 Balanced",
                    "command": "sh -c 'cpupower-gui -p && powerprofilesctl set balanced'"
                  },
                  {
                    "label": "󰾆 Power-Saver",
                    "command": "sh -c 'cpupower-gui -b && powerprofilesctl set power-saver'"
                  }
                ]
              }
      ''
    else if (config.modules.powerManagement.tlp.enable) then
      ''
        ,
              "menu#power-profiles": {
                "label": "󱐋",
                "position": "left",
                "actions": [
                  {
                    "label": "󰓅 Performance",
                    "command": "cpupower-gui -p"
                  },
                  {
                    "label": "󰾆 Power-Saver",
                    "command": "cpupower-gui -b"
                  }
                ]
              }
      ''
    else
      "";
in
{
  environment.systemPackages = with pkgs; [
    swaynotificationcenter
    wdisplays
    gpu-screen-recorder-gtk
    wofi
  ];

  services.cpupower-gui.enable = true;

  home-manager.users.${username} =
    { config, ... }:
    {
      xdg.configFile = {
        # Swaync JSON
        "swaync/config.json".text = ''
          {
            "$schema": "/etc/xdg/swaync/configSchema.json",
            "positionX": "right",
            "positionY": "top",
            "layer": "overlay",
            "control-center-layer": "top",
            "layer-shell": true,
            "cssPriority": "application",
            "control-center-width": 520,
            "control-center-margin-top": 0,
            "control-center-margin-bottom": 0,
            "control-center-margin-right": 0,
            "control-center-margin-left": 0,
            "notification-2fa-action": true,
            "notification-inline-replies": false,
            "notification-window-width": 380,
            "notification-icon-size": 48,
            "notification-body-image-height": 240,
            "notification-body-image-width": 240,
            "timeout": 8,
            "timeout-low": 4,
            "timeout-critical": 0,
            "fit-to-screen": true,
            "keyboard-shortcuts": true,
            "image-visibility": "when-available",
            "transition-time": 150,
            "hide-on-clear": true,
            "hide-on-action": true,
            "script-fail-notify": true,
            "widgets": [
              "mpris",
              "title",
              "volume",
              "notifications",
              "backlight",
              "buttons-grid"
            ],
            "widget-config": {
              "title": {
                "text": "Notifications",
                "clear-all-button": true,
                "button-text": "Clear"
              },
              "mpris": {
                "image-size": 80,
                "image-radius": 10
              },
              "volume": {
                "label": "",
                "step": 5
              },
              "backlight": {
                "label": "󰃞",
                "step": 5
              },
              "buttons-grid": {
                "actions": [
                  {
                    "label": "",
                    "command": "kitty nm-connection-editor",
                    "tooltip": "Network"
                  },
                  {
                    "label": "",
                    "command": "blueman-manager",
                    "tooltip": "Bluetooth"
                  },
                  {
                    "label": "󰂛",
                    "command": "swaync-client -d",
                    "type": "toggle",
                    "tooltip": "DND"
                  },
                  {
                    "label": "",
                    "command": "hyprlock",
                    "tooltip": "Lock"
                  },
                  {
                    "label": "󰜉",
                    "command": "reboot",
                    "tooltip": "Reboot"
                  },
                  {
                    "label": "⏻",
                    "command": "shutdown now",
                    "tooltip": "Power Off"
                  }
                ]
              }
            }
          }
        '';

        # Swaync CSS – Everforest Dark (Medium), 4px Abstand, 8px Radius
        "swaync/style.css".text = ''
          /* 1. Palette ─────────────────────────────────────────────────── */
          @define-color theme_fg             #D3C6AA;
          @define-color theme_fg_secondary   #D3C6AA;
          @define-color theme_bg             #232A2E;
          @define-color popup_bg             #232A2E;
          @define-color module_bg            #232A2E;
          @define-color module_hover_bg      #DBBC7F;
          @define-color button_bg            #A7C080;
          @define-color button_hover_bg      #DBBC7F;
          @define-color accent_color         #83C092;
          @define-color accent_color_hover   #A7C080;
          @define-color border_light         #FFFFFF;
          @define-color border_dark          #000000;
          @define-color border_medium        #808080;
          @define-color icon_primary         @theme_fg;
          @define-color icon_secondary       #D3C6AA;
          @define-color slider_trough_bg     #232A2E;
          @define-color slider_thumb_bg      #D3C6AA;
          @define-color close_button_bg      #6E6E73;
          @define-color close_button_hover_bg#828288;
          @define-color mpris_player_bg      #000000;

          /* 2. Basis-Reset ────────────────────────────────────────────── */
          * {
            font-family: "Inter", "SF Pro Text", sans-serif;
            font-size: 17px;
            color: @theme_fg;
            border: none;
            border-radius: 8px;
            background: none;
            padding: 0;
            margin: 0;
            box-shadow: none;
            text-shadow: none;
            outline: none;
          }

          /* 3. Control Center ─────────────────────────────────────────── */
          .control-center {
            margin: 4px;
            background-color: @theme_bg;
            border: 1px solid @border_medium;
            border-top-color: @border_light;
            border-bottom-color: @border_dark;
            border-radius: 8px;
            padding: 28px;
            min-width: 380px;
          }

          /* 4. Widgets ───────────────────────────────────────────────── */
          .widget-mpris,
          .widget-volume,
          .widget-backlight,
          .widget-buttons-grid,
          .control-center-list > box > *:not(.widget-title) {
            background-color: @module_bg;
            border-radius: 8px;
            padding: 18px;
            margin-bottom: 14px;
            border: 1px solid @border_medium;
          }
          .widget-volume, .widget-backlight { padding: 14px 18px; }
          .widget-buttons-grid { padding: 12px; }
          .control-center > box > *:last-child { margin-bottom: 0; }

          /* 5. Titel-Module ──────────────────────────────────────────── */
          .widget-title {
            background: none;
            border: none;
            padding: 4px 6px 12px;
            margin-bottom: 8px;
          }
          .widget-title label { font-weight: 500; color: @theme_fg_secondary; }
          .widget-title button {
            font-size: 16px;
            color: @theme_fg;
            background-color: @button_bg;
            border-radius: 8px;
            padding: 7px 16px;
            transition: background-color 0.15s ease;
          }
          .widget-title button:hover { background-color: @button_hover_bg; }

          /* 6. MPRIS Widget ─────────────────────────────────────────── */
          .widget-mpris .widget-mpris-player {
            background-color: @mpris_player_bg;
            border-radius: 8px;
            border: 1px solid @border_medium;
            padding: 16px;
          }
          .widget-mpris .widget-mpris-album-art { border-radius: 8px; margin-right: 12px; }
          .widget-mpris .widget-mpris-title    { font-size: 20px; font-weight: 600; margin-bottom: 4px; }
          .widget-mpris .widget-mpris-subtitle { font-size: 16px; }
          .widget-mpris .widget-mpris-player button:hover {
            background-color: @button_hover_bg; color: @icon_primary;
          }
          .widget-mpris .widget-mpris-player button:disabled { color: @border_medium; }

          /* 7. Slider (Volume, Backlight) ───────────────────────────── */
          .widget-volume label, .widget-backlight label { font-size: 24px; margin-right: 14px; }
          scale trough { min-height: 12px; border-radius: 6px; background-color: @slider_trough_bg; }
          scale trough progress { background-color: @accent_color; transition: background-color 0.15s ease; }
          scale:hover trough progress { background-color: @accent_color; }
          trough highlight {
            background: @accent_color; border-radius: 20px; box-shadow: 0 0 5px rgba(0,0,0,0.5);
          }
          scale slider { background-color: @slider_thumb_bg; border-radius: 7px; }

          /* 8. Button Grid ──────────────────────────────────────────── */
          .widget-buttons-grid > flowboxchild > button {
            background-color: @module_bg; border-radius: 50%; padding: 14px; min-width: 24px; min-height: 24px;
            transition: background-color 0.15s ease;
          }
          .widget-buttons-grid > flowboxchild > button:hover { background-color: @button_hover_bg; }
          .widget-buttons-grid > flowboxchild > button.toggle:checked {
            background-color: @accent_color; color: white;
          }
          .widget-buttons-grid > flowboxchild > button.toggle:checked:hover {
            background-color: @accent_color_hover;
          }

          /* 9. Notification Center & Floating ───────────────────────── */
          .control-center-list,
          .floating-notifications .notification-background {
            border-radius: 8px;
            background-color: @module_bg;
            border: 1px solid @border_medium;
            padding: 16px;
            margin: 4px;
          }
          .control-center .notification-row,
          .floating-notifications .notification-row { margin-bottom: 12px; }
          .control-center .notification-row:hover .notification-background,
          .floating-notifications .notification-row:hover .notification-background {
            background-color: @module_hover_bg;
          }
          .control-center .notification .summary,
          .floating-notifications .notification .summary {
            font-weight: 600; color: @theme_fg;
          }
          .control-center .notification .body,
          .floating-notifications .notification .body {
            color: @theme_fg_secondary;
          }
          .control-center .notification .time,
          .floating-notifications .notification .time {
            font-size: 15px; color: @icon_secondary;
          }
          .close-button {
            background-color: @close_button_bg; border-radius: 50%; min-width: 24px; min-height: 24px;
            transition: background-color 0.15s ease;
          }
          .close-button:hover { background-color: @close_button_hover_bg; }
        '';
      };
    };
}

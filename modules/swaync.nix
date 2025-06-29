{
  config,
  pkgs,
  username,
  ...
}:
let
  powerSettings =
    if (false) then
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
    else if (true) then
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
        # Swaync
        "swaync/config.json".text = ''
          {
            "$schema": "/etc/xdg/swaync/configSchema.json",
            "positionX": "right",
            "positionY": "top",
            "control-center-margin-top": 6,
            "control-center-margin-bottom": 6,
            "control-center-margin-right": 6,
            "control-center-margin-left": 6,
            "notification-icon-size": 64,
            "notification-body-image-height": 100,
            "notification-body-image-width": 200,
            "timeout": 10,
            "timeout-low": 5,
            "timeout-critical": 0,
            "fit-to-screen": true,
            "notification-window-width": 500,
            "keyboard-shortcuts": true,
            "image-visibility": "when-available",
            "transition-time": 200,
            "hide-on-clear": false,
            "hide-on-action": true,
            "script-fail-notify": true,
            "widgets": [
              "menubar",
              "buttons-grid",
              "mpris",
              "volume",
              "backlight",
              "title",
              "dnd",
              "notifications"
            ],
            "widget-config": {
              "title": {
                "text": "Notifications",
                "clear-all-button": true,
                "button-text": "Clear All"
              },
              "dnd": {
                "text": "Do Not Disturb"
              },
              "label": {
                "max-lines": 1,
                "text": "Notification Center"
              },
              "mpris": {
                "image-size": 96,
                "image-radius": 8
              },
              "volume": {
                "label": "󰕾 "
              },
              "backlight": {
                "label": "󰃟 "
              },
              "buttons-grid": {
                "actions": [
                  {
                    "label": "",
                    "command": "wofi"
                  },
                  {
                    "label": "󰍺",
                    "command": "wdisplays"
                  },
                  {
                    "label": "",
                    "command": "gpu-screen-recorder-gtk"
                  }
                ]
              },
              "menubar": {
                "menu#power-buttons": {
                  "label": "",
                  "position": "left",
                  "actions": [
                    {
                      "label": " Shut down",
                      "command": "systemctl poweroff"
                    },
                    {
                      "label": "󰜉 Reboot",
                      "command": "systemctl reboot"
                    },
                    {
                      "label": "󰒲 Suspend",
                      "command": "systemctl suspend"
                    },
                    {
                      "label": "󰋊 Hibernate",
                      "command": "systemctl hibernate"
                    },
                    {
                      "label": "󰍃 Logout",
                      "command": "niri msg action quit -s"
                    },
                    {
                      "label": "󰌾 Lock Screen",
                      "command": "loginctl lock-session"
                    }
                  ]
                }${powerSettings}
              }
            }
          }
        '';

        "swaync/style.css".text = ''
          @define-color cc-bg rgba(28, 28, 44, 1);
          @define-color noti-border-color rgba(120, 0, 0, 1);
          @define-color noti-bg rgb(28, 28, 44);
          @define-color noti-bg-darker rgb(28, 28, 44);
          @define-color noti-bg-hover rgb(34, 34, 54);
          @define-color noti-bg-focus rgba(56, 56, 56, 1);
          @define-color noti-close-bg rgba(56, 56, 56, 1);
          @define-color noti-close-bg-hover rgba(75, 75, 88, 1);
          @define-color text-color rgba(255, 255, 255, 1);
          @define-color text-color-disabled rgb(280, 280, 280);
          @define-color bg-selected rgb(224, 224, 224);

          .control-center .notification-row:focus,
          .control-center .notification-row:hover {
            opacity: 1;
            background: @noti-bg-darker
          }

          .notification-row {
            outline: none;
          }

          .notification {
            border-radius: 10px;
            margin: 6px 0px 0px 0px;
            padding: 0;
            border: 2px solid @noti-border-color
          }

          .notification-content {
            background: transparent;
            padding: 8px;
            border-radius: 10px
          }

          .close-button {
            background: @noti-close-bg;
            color: @text-color;
            text-shadow: none;
            padding: 0;
            border-radius: 100%;
            margin-top: 10px;
            margin-right: 10px;
            box-shadow: none;
            border: none;
            min-width: 24px;
            min-height: 24px
          }

          .close-button:hover {
            box-shadow: none;
            background: @noti-close-bg-hover;
            transition: all .15s ease-in-out;
            border: none
          }

          .notification-default-action,
          .notification-action {
            padding: 4px;
            margin: 0;
            box-shadow: none;
            background: @noti-bg;
            border: none;
            color: @text-color;
            transition: all .15s ease-in-out
          }

          .notification-default-action:hover,
          .notification-action:hover {
            -gtk-icon-effect: none;
            background: @noti-bg-hover
          }

          .notification-default-action {
            border-radius: 10px
          }

          .notification-default-action:not(:only-child) {
            border-bottom-left-radius: 0;
            border-bottom-right-radius: 0
          }

          .notification-action {
            border-radius: 0;
            border-top: none;
            border-right: none
          }

          .notification-action:first-child {
            border-bottom-left-radius: 6px;
            background: #1b1b2b
          }

          .notification-action:last-child {
            border-bottom-right-radius: 6px;
            background: #1b1b2b
          }

          .inline-reply {
            margin-top: 8px
          }

          .inline-reply-entry {
            background: @noti-bg-darker;
            color: @text-color;
            caret-color: @text-color;
            border: 2px solid @noti-border-color;
            border-radius: 10px
          }

          .inline-reply-button {
            margin-left: 4px;
            background: @noti-bg;
            border: 2px solid @noti-border-color;
            border-radius: 10px;
            color: @text-color
          }

          .inline-reply-button:disabled {
            background: initial;
            color: @text-color-disabled;
            border: 1px solid transparent
          }

          .inline-reply-button:hover {
            background: @noti-bg-hover
          }

          .body-image {
            margin-top: 6px;
            background-color: #fff;
            border-radius: 10px
          }

          .summary {
            font-size: 16px;
            font-weight: bold;
            background: transparent;
            color: @text-color;
            text-shadow: none
          }

          .time {
            font-size: 16px;
            font-weight: bold;
            background: transparent;
            color: @text-color;
            text-shadow: none;
            margin-right: 18px
          }

          .body {
            font-size: 15px;
            font-weight: 400;
            background: transparent;
            color: @text-color;
            text-shadow: none
          }

          .control-center {
            background: @cc-bg;
            border: 2px solid @noti-border-color;
            border-radius: 10px;
          }

          .control-center-list {
            background: transparent
          }

          .control-center-list-placeholder {
            opacity: .5
          }

          .floating-notifications {
            background: transparent
          }

          .blank-window {
            background: alpha(black, 0)
          }

          .widget-title {
            color: @text-color;
            margin: 8px;
            font-size: 1.5rem
          }

          .widget-title>button {
            font-size: initial;
            color: @text-color;
            text-shadow: none;
            background: @noti-bg;
            box-shadow: none;
            border: none;
            border-radius: 10px
          }

          .widget-title>button:hover {
            background: @noti-bg-hover
          }

          .widget-dnd {
            color: @text-color;
            margin: 8px;
            font-size: 1.1rem
          }

          .widget-dnd>switch {
            font-size: initial;
            border-radius: 15px;
            background: @noti-bg;
            border: 2px solid @noti-border-color;
            box-shadow: none
          }

          .widget-dnd>switch:checked {
            background: @bg-selected
          }

          .widget-dnd>switch slider {
            background: @noti-bg-hover;
            border-radius: 10px
          }

          .widget-label {
            margin: 8px;
          }

          .widget-label>label {
            font-size: 1.5rem;
            color: @text-color;
          }

          .widget-mpris {
            color: @text-color;
            background: @noti-bg-darker;
            padding: 8px;
            margin: 0px;
          }

          .widget-mpris-player {
            padding: 8px;
            margin: 8px
          }

          .widget-mpris-title {
            font-weight: 700;
            font-size: 1.25rem
          }

          .widget-mpris-subtitle {
            font-size: 1.1rem
          }

          .widget-buttons-grid {
            font-size: x-large;
            background: @noti-bg-darker;
          }

          .widget-menubar>box {
            border: 2px solid @noti-border-color;
            border-radius: 7px 7px 10px 10px;
            background: @noti-border-color
          }

          .widget-menubar>box>.menu-button-bar>button {
            color: @noti-bg
          }

          .power-buttons>button {
            color: @noti-bg
          }

          .power-profiles>button {
            color: @noti-bg
          }

          .widget-buttons-grid>flowbox>flowboxchild>button {
            padding: 6px 56px;
            background: transparent;
            border-radius: 10px;
            background: @noti-bg;
            color: @text-color
          }

          .widget-buttons-grid>flowbox>flowboxchild>button:hover {
            color: @noti-border-color;
            background: @noti-bg-hover;
          }
                  
          .widget-menubar>box>.menu-button-bar>button {
            border: none;
            background: transparent
          }

          .topbar-buttons>button {
            border: none;
            background: transparent
          }

          .widget-volume {
            background: @noti-bg-darker;
            padding: 8px;
            margin: 0px;
            border-radius: 10px;
            font-size: x-large;
            color: @noti-border-color 
          }

          .widget-volume>box>button {
            background: transparent;
            border: none
          }

          .per-app-volume {
            background-color: @noti-bg;
            padding: 4px 8px 8px;
            margin: 0 8px 8px;
            border-radius: 10px
          }

          .widget-backlight {
            background: @noti-bg-darker;
            padding: 8px;
            margin: 0px;
            border-radius: 0px;
            font-size: x-large;
            color: @noti-border-color
          }

          .widget-inhibitors {
            margin: 8px;
            font-size: 1.5rem
          }

          .widget-inhibitors>button {
            font-size: initial;
            color: @text-color;
            text-shadow: none;
            background: @noti-bg;
            border: 2px solid @noti-border-color;
            box-shadow: none;
            border-radius: 10px
          }

          .widget-inhibitors>button:hover {
            background: @noti-bg-hover
          }
        '';
      };
    };
}

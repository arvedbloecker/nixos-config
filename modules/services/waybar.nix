# This module configures the waybar, a program to provide a very customizable taskbar. https://github.com/Alexays/Waybar/wiki
{
  config, lib, pkgs, username, ...
}:
{
  config =
    let
      waybarSettings =
        if(config.modules.powerManagement.ppd.enable) then
        [
          {
            # General configurations
            "spacing" = 4;
            "layer" = "top";
            "position" = "bottom";
            "margin-top" = 0;
            "margin-bottom" = 0;
            "margin-left" = 0;
            "margin-right" = 0;
            "radius" = 0;
            "height" = 26;

            # Provides where and in what ordner the parts shall be ordered
            "modules-left" = [
              "niri/workspaces"
              "mpris"
            ];
            "modules-center" = [
              "niri/window"
            ];
            "modules-right" = [
              "idle_inhibitor"
              "cpu"
              "memory"
              "pulseaudio"
              "battery"
              "bluetooth"
              "power-profiles-daemon"
              "custom/vpn"
              "network"
              "clock"
              "custom/menu"
            ];
            "power-profiles-daemon" = {
              "format" = "{icon}";
              "tooltip-format" = "Power profile: {profile}\nDriver: {driver}";
              "tooltip" = true;
              "format-icons" = {
                "default" = "";
                "performance" = "";
                "balanced" = "";
                "power-saver" = "";
              };
            };
            "cpu" = {
              "interval" = 10;
              "format" = " {usage}%";
              "states" = {
                "warning" = 50;
                "critical" = 80;
              };
            };
            "memory" = {
              "interval" = 10;
              "format" = " {used}GiB";
              "states" = {
                "warning" = 70;
                "critical" = 90;
              };
            };
            # Functionality of the modules
            "niri/workspaces" = {
              "on-click" = "activate";
              "all-outputs" = false;
              "active-only" = true;
              "format" = "{icon}";
              "format-icons" = {
                "default" = "";
                "active" = "";
              };
            };
            "idle_inhibitor" = {
              "format" = "{icon}";
              "format-icons" = {
                "activated" = "󰛨";
                "deactivated" = "󰌶";
              };
              # optional: startet direkt aktiviert
              "start-activated" = false;
            };
            "mpris" = {
              "format" = "{player_icon} {title} - {artist}";
              "format-paused" = "{status_icon} {title} - {artist}";

              "player-icons" =  {
                "default" = "󰝚";
                "spotify" = "󰓇";
                "firefox" = "󰗃";
              };
              "status-icons" = {
                "paused" = "󰏤";
              };

              "tooltip-format" = "Playing: {title} - {artist}";
              "tooltip-format-paused" = "Paused: {title} - {artist}";
              "min-length" = 5;
              "max-length" = 35;

              "on-click" = "playerctl play-pause";
              "on-click-right" = "playerctl next";
            };
            "niri/window" = {
              "tooltip" = false;
            };
            "custom/vpn" = {
              "format" = "{icon} {text}";
              "exec" = "$HOME/.config/waybar/vpn-active.sh";
              "return-type" = "json";
              "interval" = 5;
              "format-icons" = [
                ""
                ""
              ];

              "on-click" = "blueman-manager";

            };

            "pulseaudio" = {
              "format" = "{icon} {volume}%";
              "format-muted" = "";
              "format-icons" = {
                "bluetooth" = "󰋋";
                "headphones" = "󰋋";
                "phone" = "";
                "default" = [
                  ""
                  ""
                  ""
                ];
              };
              "on-click" = "pwvucontrol";
              "menu" = "on-click-right";
              "menu-file" = "~/.config/waybar/audio_menu.xml";
              "menu-actions" = {
                "toggle-input" = "wpctl set-mute @DEFAULT_SOURCE@ toggle";
                "toggle-output" = "wpctl set-mute @DEFAULT_SINK@ toggle";
                "settings" = "nohup pwvucontrol > /dev/null 2>&1 & disown && exit";
                "patchbay" = "nohup helvum > /dev/null 2>&1 & disown && exit";
                "effects" = "nohup easyeffects > /dev/null 2>&1 & disown && exit";
              };
            };
            "battery" = {
              "format" = "{icon} {capacity}%";
              "states" = {
                "warning" = 30;
                "critical" = 15;
              };
              # "warning" = 30;
              # "critical" = 15;
              "format-icons" = {
                "charging" = "󰚥";
                "discharging" = [
                  "󰁻"
                  "󰁼"
                  "󰁽"
                  "󰁾"
                  "󰁿"
                  "󰂀"
                  "󰂁"
                  "󰂂"
                  "󰁹"
                ];
                "full" = "󰁹";
                "not charging" = "󱟢";
                "unknown" = "󱟢";
                "default" = "󱟢";
              };
              "tooltip" = true;
              "tooltip-format" = "{capacity}% - {timeTo}";
            };
            "bluetooth" = {
              "format" = "{icon}";
              "format-icons" = {
                "connected" = "󰂯";
                "on" = "󰂯";
                "off" = "󰂲";
                "disabled" = "󰂲";
                "powered-off" = "󰂲";
                "disconnected" = "󰂲";
                "default" = "󰂲";
              };
              "tooltip" = true;
              "tooltip-format" = "{device_alias} ({device_address})";

              "on-click" = "blueman-manager";

            };
            "network" = {
              "format-wifi" = "{icon} {bandwidthDownBytes}  {bandwidthUpBytes}  ";
              "format-ethernet" = "󰈀 ";
              "format-disconnected" = "󰖪";
              "format-icons" = {
                "wifi" = [
                  "󰤯"
                  "󰤟"
                  "󰤢"
                  "󰤥"
                  "󰤨"
                ];
              };
              "tooltip" = true;
              "tooltip-format-wifi" = "{essid} ({signalStrength}%)\n{ipaddr}";
              "tooltip-format-ethernet" = "{ifname}\n{ipaddr}";
              "tooltip-format-disconnected" = "Nicht verbunden";
              "on-click" = "nm-connection-editor";
            };
            "clock" = {
              "format" = "{:%y-%m-%d %H:%M}";
              "tooltip" = false;
            }; 
            "custom/menu" = {
              "format" = "{icon:2}";
              "tooltip" = true;
              "format-icons" = {
                "notification" = "";
                "none" = "";
                "dnd-notification" = "";
                "dnd-none" = "";
                "inhibited-notification" = "";
                "inhibited-none" = "";
                "dnd-inhibited-notification" = "";
                "dnd-inhibited-none" = "";
              };
              "exec" = "swaync-client -swb";
              "return-type" = "json";
              "on-click" = "swaync-client -t -sw";
              "menu" = "on-click-right";
              "menu-file" = "~/.config/waybar/notify_menu.xml";
              "menu-actions" = {
                "toggle-dnd" = "swaync-client -d -sw";
                "clear-all" = "swaync-client -C -sw";
              };
            };
          }
        ]
        else
        [
          {
            # General configurations
            "spacing" = 4;
            "layer" = "top";
            "position" = "bottom";
            "margin-top" = 0;
            "margin-bottom" = 0;
            "margin-left" = 0;
            "margin-right" = 0;
            "radius" = 0;
            "height" = 26;

            # Provides where and in what ordner the parts shall be ordered
            "modules-left" = [
              "niri/workspaces"
              "mpris"
            ];
            "modules-center" = [
              "niri/window"
            ];
            "modules-right" = [
              "idle_inhibitor"
              "cpu"
              "memory"
              "pulseaudio"
              "battery"
              "bluetooth"
              "custom/vpn"
              "network"
              "clock"
              "custom/menu"
            ];

            "cpu" = {
              "interval" = 10;
              "format" = " {usage}%";
              "states" = {
                "warning" = 50;
                "critical" = 80;
              };
            };

            "memory" = {
              "interval" = 10;
              "format" = " {used}GiB";
              "states" = {
                "warning" = 70;
                "critical" = 90;
              };
            };
          
            # Functionality of the modules
            "niri/workspaces" = {
              "on-click" = "activate";
              "all-outputs" = false;
              "active-only" = true;
              "format" = "{icon}";
              "format-icons" = {
                "default" = "";
                "active" = "";
              };
            };
            "idle_inhibitor" = {
              "format" = "{icon}";
              "format-icons" = {
                "activated" = "󰛨";
                "deactivated" = "󰌶";
              };
              # optional: startet direkt aktiviert
              "start-activated" = false;
            };
            "mpris" = {
              "format" = "{player_icon} {title} - {artist}";
              "format-paused" = "{status_icon} {title} - {artist}";

              "player-icons" =  {
                "default" = "󰝚";
                "spotify" = "󰓇";
                "firefox" = "󰗃";
              };
              "status-icons" = {
                "paused" = "󰏤";
              };

              "tooltip-format" = "Playing: {title} - {artist}";
              "tooltip-format-paused" = "Paused: {title} - {artist}";
              "min-length" = 5;
              "max-length" = 35;

              "on-click" = "playerctl play-pause";
              "on-click-right" = "playerctl next";
            };
            "niri/window" = {
              "tooltip" = false;
            };
            "custom/vpn" = {
              "format" = "{icon} {text}";
              "exec" = "$HOME/.config/waybar/vpn-active.sh";
              "return-type" = "json";
              "interval" = 5;
              "format-icons" = [
                ""
                ""
              ];

              "on-click" = "blueman-manager";

            };

            "pulseaudio" = {
              "format" = "{icon} {volume}%";
              "format-muted" = "";
              "format-icons" = {
                "bluetooth" = "󰋋";
                "headphones" = "󰋋";
                "phone" = "";
                "default" = [
                  ""
                  ""
                  ""
                ];
              };
              "on-click" = "pwvucontrol";
              "menu" = "on-click-right";
              "menu-file" = "~/.config/waybar/audio_menu.xml";
              "menu-actions" = {
                "toggle-input" = "wpctl set-mute @DEFAULT_SOURCE@ toggle";
                "toggle-output" = "wpctl set-mute @DEFAULT_SINK@ toggle";
                "settings" = "nohup pwvucontrol > /dev/null 2>&1 & disown && exit";
                "patchbay" = "nohup helvum > /dev/null 2>&1 & disown && exit";
                "effects" = "nohup easyeffects > /dev/null 2>&1 & disown && exit";
              };
            };
            "battery" = {
              "format" = "{icon} {capacity}%";
              "states" = {
                "warning" = 30;
                "critical" = 15;
              };
              # "warning" = 30;
              # "critical" = 15;
              "format-icons" = {
                "charging" = "󰚥";
                "discharging" = [
                  "󰁻"
                  "󰁼"
                  "󰁽"
                  "󰁾"
                  "󰁿"
                  "󰂀"
                  "󰂁"
                  "󰂂"
                  "󰁹"
                ];
                "full" = "󰁹";
                "not charging" = "󱟢";
                "unknown" = "󱟢";
                "default" = "󱟢";
              };
              "tooltip" = true;
              "tooltip-format" = "{capacity}% - {timeTo}";
            };
            "bluetooth" = {
              "format" = "{icon}";
              "format-icons" = {
                "connected" = "󰂯";
                "on" = "󰂯";
                "off" = "󰂲";
                "disabled" = "󰂲";
                "powered-off" = "󰂲";
                "disconnected" = "󰂲";
                "default" = "󰂲";
              };
              "tooltip" = true;
              "tooltip-format" = "{device_alias} ({device_address})";

              "on-click" = "blueman-manager";

            };
            "network" = {
              "format-wifi" = "{icon} {bandwidthDownBytes}  {bandwidthUpBytes}  ";
              "format-ethernet" = "󰈀 ";
              "format-disconnected" = "󰖪";
              "format-icons" = {
                "wifi" = [
                  "󰤯"
                  "󰤟"
                  "󰤢"
                  "󰤥"
                  "󰤨"
                ];
              };
              "tooltip" = true;
              "tooltip-format-wifi" = "{essid} ({signalStrength}%)\n{ipaddr}";
              "tooltip-format-ethernet" = "{ifname}\n{ipaddr}";
              "tooltip-format-disconnected" = "Nicht verbunden";
              "on-click" = "nm-connection-editor";
            };
            "clock" = {
              "format" = "{:%y-%m-%d %H:%M}";
              "tooltip" = false;
            }; 
            "custom/menu" = {
              "format" = "{icon:2}";
              "tooltip" = true;
              "format-icons" = {
                "notification" = "";
                "none" = "";
                "dnd-notification" = "";
                "dnd-none" = "";
                "inhibited-notification" = "";
                "inhibited-none" = "";
                "dnd-inhibited-notification" = "";
                "dnd-inhibited-none" = "";
              };
              "exec" = "swaync-client -swb";
              "return-type" = "json";
              "on-click" = "swaync-client -t -sw";
              "menu" = "on-click-right";
              "menu-file" = "~/.config/waybar/notify_menu.xml";
              "menu-actions" = {
                "toggle-dnd" = "swaync-client -d -sw";
                "clear-all" = "swaync-client -C -sw";
              };
            };
          }
        ];
    in
    {
      # Packages that will be installed with the waybar
      environment.systemPackages = with pkgs; [
        easyeffects
        pwvucontrol
        helvum
        swaynotificationcenter
        wttrbar
        playerctl
      ];

      home-manager.users.${username} =
        { config, lib, ... }:
        {

          # Files will be put in ~/.config/waybar which can be executed.
          xdg.configFile = {
            "waybar/audio_menu.xml".text = ''
              <?xml version="1.0" encoding="UTF-8"?>
              <interface>
                <object class="GtkMenu" id="menu">
                  <child><object class="GtkMenuItem" id="toggle-input"><property name="label">Toggle Input</property></object></child>
                  <child><object class="GtkMenuItem" id="toggle-output"><property name="label">Toggle Output</property></object></child>
                  <child><object class="GtkMenuItem" id="settings"><property name="label">Settings</property></object></child>
                  <child><object class="GtkMenuItem" id="patchbay"><property name="label">Patchbay</property></object></child>
                  <child><object class="GtkMenuItem" id="effects"><property name="label">Effects</property></object></child>
                </object>
              </interface>
            '';
            "waybar/notify_menu.xml".text = ''
              <?xml version="1.0" encoding="UTF-8"?>
              <interface>
                <object class="GtkMenu" id="menu">
                  <child><object class="GtkMenuItem" id="toggle-dnd"><property name="label">Toggle Do Not Disturb</property></object></child>
                  <child><object class="GtkMenuItem" id="clear-all"><property name="label">Clear All Notifications</property></object></child>
                </object>
              </interface>
            '';
            "waybar/vpn-active.sh" = {
              text = ''
                #!/usr/bin/env bash

                # nmcli connection show --active | grep -iq vpn \
                # && echo '{"text":"Connected","class":"connected","percentage":100}' \
                # || echo '{"text":"Disconnected","class":"disconnected","percentage":0}'

                name=$(nmcli -t -f NAME,TYPE connection show --active \
                       | awk -F: '$2=="vpn"{print $1; exit}')

                [ -n "$name" ] \
                  && echo "{\"text\":\"$name\",\"class\":\"connected\",\"percentage\":100}" \
                  || echo '{"text":"","class":"disconnected","percentage":0}'

              '';
              executable = true;
            };
          };

          programs.waybar = {
            enable = true;
            settings = waybarSettings;

            # CSS-Styling for the Waybar
            style = ''

              @define-color bg rgba(33,39,51, 0.9);
              @define-color border rgba(104, 157, 106, 1);
              @define-color text #cccac2;

              @define-color warning #ffad66;
              @define-color critical red;
                          
              * {
                font-size: 10px;
                font-family: "JetBrainsMono Nerd Font Propo";
                font-weight: Bold;
                padding: 0 4px 0 4px;
                border-radius: 4px;
              }
              window#waybar {
                background: @bg;
                border: Solid;
                border-radius: 0px;
                border-width: 0px;
                border-color: @border;
                color: @text;
              }
              
              #workspaces button {
                background: transparent;
                border: none;
                color: @text;
                margin: 0;
                transition: none;
              }
              #workspaces button.active {
                background: transparent;
                border: none;
                color: @text;
                margin: 0;
                transition: none;
              }
              /* Stop annoying animations when hovering */
              #workspaces button:hover {
                background: transparent;
                border: none;
                box-shadow: none;
                text-shadow: none;
              }

              #bluetooth, #network, #pulseaudio, #custom-menu {
                margin-left: 2px;
                margin-right: 2px;
              }

              /* Box around each element
              #custom-weather, #mpris {
                margin: 2px;
                background-color: rgba(0, 0, 0, 0.3);
                color: @white;
              }
              */

              #idle_inhibitor.activated {
                color: @warning;
              }
              #custom-vpn.connected {
                color: @warning;
              }
              #pulseaudio.muted {
                color: @warning;
              }

              #cpu.warning {
                color: @warning;
              }
              #cpu.critical {
                color: @critical;
              }

              /* Arbeitsspeicher */
              #memory.warning {
                color: @warning;
              }
              #memory.critical {
                color: @critical;
              }

              /* Akkustand */
              #battery.warning {
                color: @warning;
              }
              #battery.critical {
                color: @critical;
              }

              #power-profiles-daemon.performance {
                color: @warning;
              }

              '';
          };
        };
    };
}

{
  config, lib, pkgs, username, ...
}:
{
  config =
    let
      waybarSettings = [
        {
          "spacing" = 4;
          "layer" = "top";
          "position" = "top";
          "margin-top" = 4;
          "margin-bottom" = 0;
          "margin-left" = 4;
          "margin-right" = 4;
          "radius" = 4;
          "height" = 26;
          "modules-left" = [
            "niri/workspaces"
            "custom/weather"
            "custom/nextcloud"
            "mpris"
          ];
          "modules-center" = [
            "niri/window"
          ];
          "modules-right" = [
            "pulseaudio"
            "battery"
            "bluetooth"
            "network"
            "clock"
            "custom/menu"
          ];
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
          "custom/nextcloud" = {
            "on-click" = "nextcloud";
            "on-click-right" = "nextcloud --background";
            "exec" = "~/.config/waybar/nxtcloud.sh";
            "interval" = 30;
            "format" = "{}";
            "return-type" = "json";
          };
          "custom/weather" = {
            "format" = "{text}°";
            "tooltip" = true;
            "interval" = 3600;
            "exec" = "wttrbar --location Hannover --nerd";
            "return-type" = "json";
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
            "format-wifi" = "{icon}";
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
            "format" = "{:%H:%M  %y-%m-%d}";
            "tooltip" = false;
          }; 
          "custom/menu" = {
            "format" = "{icon:2}";
            "tooltip" = true;
            "format-icons" = {
              "notification" = "<span foreground='#E03535'><sup></sup></span>";
              "none" = "";
              "dnd-notification" = "<span foreground='#E03535'><sup></sup></span>";
              "dnd-none" = "";
              "inhibited-notification" = "<span foreground='#E03535'><sup></sup></span>";
              "inhibited-none" = "";
              "dnd-inhibited-notification" = "<span foreground='#E03535'><sup></sup></span>";
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
      environment.systemPackages = with pkgs; [
        easyeffects
        pwvucontrol
        helvum
        swaynotificationcenter
        wdisplays
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

            # A Script that checks if Nextcloud is running or not
            "waybar/nxtcloud.sh" = {
              text = ''
                #!/usr/bin/env bash
                # Nextcloud-Status-Check für Waybar

                output=$(pgrep -f nextcloud)
                  
                if [ -z "$output" ]; then
                  echo '{"text":"󰅤","class":"inactive"}' 
                else
                  echo '{"text":"󱋖","class":"active"}'
                fi
              '';
              # Script muss ausführbar sein:
              executable = true;
            };
          };

          programs.waybar = {
            enable = true;
            settings = waybarSettings;

            # CSS-Styling for the Waybar
            style = ''

              @define-color bg rgba(40, 40, 40, 0.6);
              @define-color border rgba(104, 157, 106, 1);
              @define-color text rgba(235, 219, 178, 1);
            
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
                border-radius: 4px;
                border-width: 3px;
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
              '';
          };
        };
    };
}

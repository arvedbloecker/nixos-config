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
          "margin-top" = 2;
          "margin-bottom" = 2;
          "margin-left" = 2;
          "margin-right" = 2;
          "height" = 26;
          "modules-left" = [
            "clock"
          ];
          "modules-right" = [
            "pulseaudio"
            "custom/display"
            "bluetooth"
            "network"
            "battery"
            "custom/menu"
          ];
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
            "on-click" = "blueman-manager";
            "tooltip" = true;
            "tooltip-format" = "{device_alias} ({device_address})";

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
          "battery" = {
            "format" = "{icon}";
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
          "clock" = {
            "format" = "󱑇 {:%H:%M}";
            "tooltip" = false;
          };
          "pulseaudio" = {
            "format" = "{icon} {volume}%";
            "format-bluetooth" = "{icon}󰂯 {volume}%";
            "format-muted" = "";
            "format-icons" = {
              "headphones" = "󰋋 ";
              "phone" = " ";
              "default" = [
                ""
                " "
                " "
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
          "tray" = {
            "spacing" = 4;
            "reverse-direction" = true;
          };
          "custom/menu" = {
            "format" = "{icon}";
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
          "custom/display" = {
            "format" = "󰍹";
            "tooltip" = true;
            "tooltip-format" = "Display Settings";
            "on-click" = "wdisplays";
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
      ];

      home-manager.users.${username} =
        { config, lib, ... }:
        {
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
          };

          programs.waybar = {
            enable = true;
            settings = waybarSettings;
            style = ''
              * {
                font-size: 12px;
                font-family: "Nerdfonts";
                font-weight: Bold;
                padding: 0 4px 0 4px;
              }
              window#waybar {
                background: rgba(15, 15, 15, 0.7);
                color: #E8F5E9;
                border: Solid;
                border-radius: 4px;
                border-width: 2px;
                border-color: rgba(0, 120, 90, 1);
              }
              #workspaces button {
                background: #0F0F0F;
                color: #E0E0E0;
                margin: 4px 2px 4px 2px;
                padding: 0;
              }
              #workspaces button.active {
                background: #0F0F0F;
                color: #E0E0E0;
                margin: 4px 2px 4px 2px;
              }
              #tray {
                padding: 0;
              }
              #bluetooth, #network, #pulseaudio, #custom-menu #custom-display{
                margin-left: 2px;
                margin-right: 2px;
              }
            '';
          };
        };
    };
}

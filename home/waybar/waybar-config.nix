{
  layer = "top";
  position = "top";
  height = 28;

  modules-left = [ "sway/workspaces" ];
  modules-center = [ "clock" ];
  modules-right = [
    "pulseaudio"
    "battery"
    "cpu"
    "memory"
    "network"
    "tray"
  ];

  "sway/workspaces" = {
    disable-scroll = true;
    format = "{icon}";
  };

  clock = {
    format = "{:%a, %d. %b  %H:%M}";
    tooltip-format = "{:%Y-%m-%d %H:%M:%S}";
  };

  pulseaudio = {
    format = "{icon} {volume}%";
    format-muted = "";
    format-icons = [ "" "" "" ];
    on-click = "pavucontrol";
  };

  battery = {
    format = "{icon} {capacity}%";
    format-charging = " {capacity}%";
    format-icons = [ "" "" "" "" "" ];
  };

  cpu = {
    format = " {usage}%";
  };

  memory = {
    format = " {used:0.1f}G";
  };

  network = {
    format-wifi = " {essid}";
    format-ethernet = " {ipaddr}";
    format-disconnected = "";
  };

  tray = {
    spacing = 10;
  };
}

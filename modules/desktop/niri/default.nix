{ pkgs, inputs, username, ... }:
{
  # Niri-Overlay aktivieren
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  niri-flake.cache.enable = false;

  # Systempakete für alle Nutzer
  environment.systemPackages = with pkgs; [
    kanshi
    wofi
    xwayland-satellite
    waybar
  ];

  # Home-Manager Benutzerkonfiguration
  home-manager.users.${username} = { pkgs, config, ... }: {
    programs = {
      # Aktiviere Niri mit Deinen Settings
      niri = {
        enable = true;
        settings = {
          input = {
            keyboard.xkb = {
              layout = "us";
              variant = "altgr-intl";
            };
            touchpad = {
              tap = true;
              natural-scroll = true;
              accel-profile = "flat";
            };
            mouse = { accel-profile = "flat"; };
            warp-mouse-to-focus = true;
            focus-follows-mouse = { max-scroll-amount = "0%"; };
          };
          cursor = {
            xcursor-theme = "Adwaita";
            xcursor-size = 16;
            hide-after-inactive-ms = 1000;
          };
          environment = {
            ELECTRON_OZONE_PLATFORM_HINT = "wayland";
            DISPLAY = ":0";
          };
          layout = {
            gaps = 0;
            center-focused-column = "on-overflow";
            preset-column-widths = [ { proportion = 0.33333; } { proportion = 0.5; } { proportion = 0.66667; } ];
            preset-window-heights = [ { proportion = 0.5; } { proportion = 1.0; } ];
            default-column-width = { proportion = 0.5; };
            focus-ring = { off = true; };
            border = {
              width = 2;
              inactive-color = "#595959";
              active-gradient = { from = "#33ccff"; to = "#00ff99"; angle = 45; relative-to = "workspace-view"; };
            };
          };
          spawn-at-startup = [ "kanshi" "xwayland-satellite" "waybar" ];
          prefer-no-csd = true;
          screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d:%H-%M-%S-Screenshot.png";
          window-rule = [
            { match = { app-id = "firefox$"; title = "^Picture-in-Picture$"; }; open-floating = true; }
          ];
          binds = with config.lib.niri.actions; {
            "Mod+Shift+Slash".action = show-hotkey-overlay;
            "Mod+E"              .action = spawn "ghostty";
            "Mod+P"              .action = spawn "firefox";
            "Mod+Return"         .action = spawn "fuzzel";
            "Mod+Shift+L"        .action = spawn "dm-tool lock";

            XF86AudioRaiseVolume.allow-when-locked = true;
            XF86AudioRaiseVolume.action       = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
            XF86AudioLowerVolume.allow-when-locked = true;
            XF86AudioLowerVolume.action       = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
            XF86AudioMute.allow-when-locked        = true;
            XF86AudioMute.action              = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
            XF86AudioMicMute.allow-when-locked     = true;
            XF86AudioMicMute.action           = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

            XF86MonBrightnessUp.action   = spawn "brightnessctl" "set" "+5%";
            XF86MonBrightnessDown.action = spawn "brightnessctl" "set" "5%-";

            "Mod+X" .action = close-window;
            "Mod+H" .action = focus-column-or-monitor-left;
            "Mod+J" .action = focus-window-or-workspace-down;
            "Mod+K" .action = focus-window-or-workspace-up;
            "Mod+L" .action = focus-column-or-monitor-right;
            "Mod+Left"  .action = focus-monitor-left;
            "Mod+Down"  .action = focus-monitor-down;
            "Mod+Up"    .action = focus-monitor-up;
            "Mod+Right" .action = focus-monitor-right;
            "Mod+Home"  .action = focus-column-first;
            "Mod+End"   .action = focus-column-last;

            # … füge hier die restlichen Tastenbindungen aus Deinem Original ein …
          };
        };
      };
      # Weitere Home-Manager-Programme
      waybar.enable = true;
      wofi.enable   = true;
    };
  };
}

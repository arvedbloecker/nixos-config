{ lib, pkgs, ... }:
let
  bgImage = ./../../pkgs/wallpaper/RedBlueMountain.png;
in
{
  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "console=tty12"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;

  services.displayManager.sessionPackages = [
    pkgs.niri
  ];

  environment.etc."share/wayland-sessions/gnome.desktop".text = ''
    [Desktop Entry]
    Name=GNOME
    Comment=This session logs you into GNOME
    Exec=${pkgs.gnome-session}/bin/gnome-session
    TryExec=${pkgs.gnome-session}/bin/gnome-session
    Type=Application
    DesktopNames=GNOME
  '';

  environment.etc."greetd/foot.ini".text = ''
    [colors]
    background=1f2439
    foreground=ffffff

    [main]
    font=JetBrainsMono Nerd Font:size=20
    pad=20x20
  '';

  environment.etc."greetd/niri-greeter.kdl".text =
    let
      theme = "border=#ffad66;text=white;prompt=#ffad66;time=white;action=#ffad66;button=#ffad66;container=#1f2439;input=white";
      tuigreetCmd = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --asterisks --sessions /run/current-system/sw/share/wayland-sessions:/run/current-system/sw/share/xsessions --theme '${theme}'";
    in
    ''
      animations { off; }

      hotkey-overlay {
        skip-at-startup;
      }

      spawn-at-startup "${pkgs.swaybg}/bin/swaybg" "-m" "fill" "-i" "${bgImage}"
      spawn-at-startup "${pkgs.foot}/bin/foot" "--fullscreen" "--config=/etc/greetd/foot.ini" \
        "--" "${pkgs.bash}/bin/sh" "-c" \
        "COLORTERM=truecolor ${tuigreetCmd}; ${pkgs.niri}/bin/niri msg action quit --skip-confirmation"
    '';

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.niri}/bin/niri --config /etc/greetd/niri-greeter.kdl";
        user = "greeter";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = lib.mkForce "simple";
    StandardInput = "tty";
    StandardOutput = "null";
    StandardError = "journal";
    TTYReset = true;
  };
}

{ pkgs, ... }:
{
  # 1. Configure the foot terminal for a seamless look
  environment.etc."greetd/foot.ini".text = ''
    [colors]
    background=1f2439
    foreground=ffffff

    [main]
    font=JetBrainsMono Nerd Font:size=20
    pad=20x20
  '';

  # 2. Configure greetd to launch tuigreet inside foot and cage
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          let
            theme = "border=#ffad66;text=white;prompt=#ffad66;time=white;action=#ffad66;button=#ffad66;container=#1f2439;input=white";
            tuigreetCmd = "${pkgs.tuigreet}/bin/tuigreet --time --remember --asterisks --cmd niri-session --theme '${theme}'";
          in
          # cage starts a minimal Wayland compositor, foot provides a TrueColor terminal
          "${pkgs.cage}/bin/cage -s -- ${pkgs.foot}/bin/foot --config=/etc/greetd/foot.ini -- ${pkgs.bash}/bin/sh -c 'COLORTERM=truecolor ${tuigreetCmd}'";
        user = "greeter";
      };
    };
  };

  # Graphical session handles the display better than TTY console
  services.kmscon.enable = false;
}

# Kitty is a terminal emulator
{
  pkgs,
  username,
  ...
}:
{
  home-manager.users.${username} =
    { config, ... }:
    {
      programs.kitty = {
        enable = true;
        settings = {
          editor = "hx";
          term = "xterm-256color";
          window_padding_width = 4;
          confirm_os_window_close = 0;
          # background_opacity = "0.9";
          # Remote control für Theme-Toggle über alle Instanzen
          allow_remote_control = "yes";
          listen_on = "unix:/tmp/kitty-{kitty_pid}";
        };
        extraConfig = ''
          # Dark als Default
          include dark-theme.conf
          # Wird vom theme-toggle Script überschrieben (ignoriert falls fehlt)
          include current-theme.conf
        '';
      };

      xdg.configFile."kitty/dark-theme.conf".text = ''
        background_opacity 0.9

        background #212733
        foreground #d9d7ce
        cursor #ffcc66
        selection_background #343f4c
        selection_foreground #212733

        color0  #191e2a
        color1  #ed8274
        color2  #a6cc70
        color3  #fad07b
        color4  #6dcbfa
        color5  #cfbafa
        color6  #90e1c6
        color7  #c7c7c7
        color8  #686868
        color9  #f28779
        color10 #bae67e
        color11 #ffd580
        color12 #73d0ff
        color13 #d4bfff
        color14 #95e6cb
        color15 #ffffff
      '';

      xdg.configFile."kitty/light-theme.conf".text = ''
        background_opacity 0.95

        background    #edebea
        # background    #f2eeea
        foreground    #2d3138
        cursor        #c5282e
        selection_foreground #ffffff
        selection_background #a86200

        color0  #3a4248
        color1  #c5282e
        color2  #507000
        color3  #a86200
        color4  #1060a0
        color5  #6844a8
        color6  #1a7a57
        color7  #5c6470
        color8  #2a2f3a
        color9  #d43a40
        color10 #5a8000
        color11 #c47500
        color12 #1a70c0
        color13 #7850c0
        color14 #228a65
        color15 #8a9199
      '';
    };
}

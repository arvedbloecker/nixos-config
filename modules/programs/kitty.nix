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

        background    #ffffff
        foreground    #5c6166
        cursor        #f07178
        selection_foreground #faf4ed
        selection_background #e6b673

        color0  #626a73
        color1  #f07178
        color2  #86b300
        color3  #f29718
        color4  #41a6d9
        color5  #a37acc
        color6  #4dbf99
        color7  #8a9199
        color8  #4d5566
        color9  #f07178
        color10 #86b300
        color11 #f29718
        color12 #41a6d9
        color13 #a37acc
        color14 #4dbf99
        color15 #faf4ed
      '';
    };
}

{
  pkgs,
  username,
  ...
}:
{
  home-manager.users.${username} = { config, ... }: {

    programs.kitty = {
      enable = true;

      extraConfig = ''
        # Gruvbox Dark – Medium

        ## Hintergrund und Text
        # bg0
        background            #282828
        # fg0
        foreground            #FBF1C7

        ## Auswahl
        # bg0_s
        selection_background  #FBF1C7
        # fg0
        selection_foreground  #282828

        ## Links
        # aqua0
        url_color             #689D6A

        ## Cursor
        # yellow1
        cursor                #FABD2F
        # bg0
        cursor_text_color     #282828

        ## ANSI-Farben (0–7)
        # black (bg0)
        color0   #282828
        # red0
        color1   #CC241D
        # green0
        color2   #98971A
        # yellow0
        color3   #D79921
        # blue0
        color4   #458588
        # purple0
        color5   #B16286
        # aqua0
        color6   #689D6A
        # gray
        color7   #A89984

        ## Helle ANSI-Farben (8–15)
        # gray (bright)
        color8   #928374
        # red1
        color9   #FB4934
        # green1
        color10  #B8BB26
        # yellow1
        color11  #FABD2F
        # blue1
        color12  #83A598
        # purple1
        color13  #D3869B
        # aqua1
        color14  #8EC07C
        # fg0 (bright white)
        color15  #FBF1C7

        window_padding_width  4

        confirm_os_window_close 0
      '';
    };

  };
}

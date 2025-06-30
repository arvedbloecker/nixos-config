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
        # Everforest Dark – Medium (Default)

        ## Farben
        background            #232A2E
        foreground            #D3C6AA

        selection_background  #2D353B
        selection_foreground  #D3C6AA

        url_color             #83C092

        cursor                #E67E80
        cursor_text_color     #232A2E

        ## ANSI-Farben (0–7)
        color0   #D3C6AA
        color1   #E67E80
        color2   #A7C080
        color3   #DBBC7F
        color4   #7FBBB3
        color5   #D699B6
        color6   #83C092
        color7   #9DA9A0

        ## Helle ANSI-Farben (8–15)
        color8   #7A8478
        color9   #E67E80
        color10  #A7C080
        color11  #DBBC7F
        color12  #7FBBB3
        color13  #D699B6
        color14  #83C092
        color15  #9DA9A0

        window_padding_width  4
      '';
    };

  };
}

{
  username,
  ...
}: {
  home-manager.users.${username} = { config, ... }: {
    programs.wofi = {
      enable = true;

      settings = {
        show = "drun";
        width = 512;
        height = 384;
        always_parse_args = true;
        show_all = true;
        print_command = true;
        prompt = "";
        layer = "overlay";
        insensitive = true;
        content_halign = "top";
        allow_images = true;
      };

    style = ''
      /* Catppuccin Mocha Colors */
      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color crust  #11111b;

      @define-color text rgb(200,200,200);
      /*@define-color text   #cdd6f4;*/
      @define-color red    #f38ba8;
      @define-color surface0  #313244;
      @define-color surface1  #45475a;
      @define-color surface2  #585b70;

      #window {
        margin: 0px;
        border: 2px solid rgb(120, 0, 0);
        border-radius: 10px;
        background-color: rgba(30, 30, 46, 0.7);
        font-size: 16px;
        font-weight: bold;
      }

      #input {
        border-radius: 8px;
        color: @text;
        background-color: rgba(24, 24, 37, 0.9);
        padding: 6px 8px;
        font-size: 16px;
        border: 2px solid rgb(120,0,0);
        margin-bottom: 6px;
      }

      #outer-box {
        margin: 8px;
        border: none;
        background-color: transparent;
        border-radius: 8px;
      }

      #text {
        margin: 0px 8px;
        border: none;
        color: @text;
      }

      #entry:selected {
        background-color: @surface2;
        font-weight: normal;
        border-radius: 8px;
      }

      #text:selected {
        background-color: @surface2;
        color: @text;
        font-weight: normal;
      }

      #expander-box {
        background: @surface0;
        color: @text;
        font-weight: normal;
      }

      #expander-box:selected {
        background: @surface1;
        color: @text;
        font-weight: normal;
      }

      /* Override the blue selection indicator (e.g. app icon circle) */
      #entry:selected image {
        background-color: white;
        color: white;
        border-radius: 50%;
      }
    '';
    };
  };
}

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


      @define-color dark-gray rgb(40, 40, 40);
      @define-color light-beige #D3C6AA;
      @define-color soft-red #E67E80;
      @define-color soft-cyan rgb(104, 157, 106);
    
      @define-color base   rgb(40, 40, 40); /* Dark Gray */
      @define-color mantle #181825;
      @define-color crust  rgb(104, 157, 106); /* Soft Cyan */

      @define-color text   rgb(251, 241, 199);
      @define-color red    #f38ba8;
      @define-color surface0  #313244;
      @define-color surface1  #45475a;
      @define-color surface2  #585b70;

      #window {
        margin: 0px;
        border: 2px solid @soft-cyan;
        border-radius: 10px;
        background-color: @dark-gray;
        font-size: 16px;
        font-weight: bold;
      }

      #input {
        border-radius: 8px;
        color: @text;
        background-color: @dark-gray;
        padding: 6px 8px;
        font-size: 16px;
        border: 4px solid @soft-cyan;
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
        background-color: @dark-gray;
        font-weight: normal;
        border-radius: 8px;
      }

      #text:selected {
        background-color: @dark-gray;
        color: @text;
        font-weight: normal;
      }

      #expander-box {
        background: @dark-gray;
        color: @text;
        font-weight: normal;
      }

      #expander-box:selected {
        background: @dark-gray;
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

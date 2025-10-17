# Wofi is a app-launcher
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


      @define-color dark-gray rgba(40, 40, 40, 0.98);
      @define-color light-beige #D3C6AA;
      @define-color soft-red #E67E80;
      @define-color soft-cyan rgb(104, 157, 106);
      @define-color ayu-mirage-blue rgba(33,39,51,0.95);
      @define-color ayu-mirage-orange #ffad66;
          
      @define-color base   ayu-mirage-blue; /* Dark Gray */
      @define-color mantle #181825;
      @define-color crust  rgb(104, 157, 106); /* Soft Cyan */

      @define-color text   #cccac2; /* white */
      @define-color red    #f38ba8;
      @define-color surface0  #313244;
      @define-color surface1  #45475a;
      @define-color surface2  #585b70;

      #window {
        margin: 0px;
        border: 2px solid @ayu-mirage-orange;
        border-radius: 10px;
        background-color: @ayu-mirage-blue;
        font-size: 16px;
        font-weight: normal;
      }

      #input {
        border-radius: 8px;
        color: @text;
        background-color: @ayu-mirage-blue;
        padding: 6px 8px;
        font-size: 16px;
        border: 4px solid @ayu-mirage-orange;
        margin-bottom: 6px;
      }

      #outer-box {
        margin: 8px;
        border: none;
        border-radius: 10px;
        background-color: transparent;
        border-radius: 8px;
      }

      #text {
        margin: 0px 8px;
        border: none;
        color: @text;
      }

      #entry:selected {
        background-color: @ayu-mirage-blue;
        font-weight: bold;
        border-radius: 8px;
      }

      #text:selected {
        background-color: @ayu-mirage-blue;
        color: @text;
        font-weight: bold;
      }

      #expander-box {
        background: @ayu-mirage-blue;
        color: @text;
        font-weight: normal;
      }

      #expander-box:selected {
        background: @ayu-mirage-blue;
        color: @text;
        font-weight: normal;
      }

      /* Override the blue selection indicator (e.g. app icon circle) */
      #entry:selected image {
        background-color: transparent;
        color: white;
        border-radius: 50%;
      }
    '';
    };
  };
}

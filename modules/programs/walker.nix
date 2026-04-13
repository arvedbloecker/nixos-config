{
  username,
  inputs,
  ...
}: {
  home-manager.users.${username} = {
    imports = [inputs.walker.homeManagerModules.default];

    home.packages = with pkgs; [
      bitwarden-cli
    ];

    programs.walker = {
      enable = true;
      runAsService = true;

      # All options from the config.toml can be used here
      config = {
        theme = "ayu-mirage";
        app_launch_prefix = "";
        search.placeholder = "Search...";
        ui.width = 512;
        ui.height = 384;
        
        # Modules configuration
        providers.prefixes = [
          {
            provider = "applications";
            prefix = "";
          }
          {
            provider = "calc";
            prefix = "=";
          }
          {
            provider = "files";
            prefix = "/";
          }
          {
            provider = "websearch";
            prefix = "@";
          }
          {
            provider = "clipboard";
            prefix = ":";
          }
          {
            provider = "symbols";
            prefix = ".";
          }
          {
            provider = "todo";
            prefix = "!";
          }
          {
            provider = "bitwarden";
            prefix = "bw";
          }
          {
            provider = "nirisessions";
            prefix = "ns";
          }
          {
            provider = "unicode";
            prefix = "u";
          }
          {
            provider = "bluetooth";
            prefix = "bt";
          }
          {
            provider = "playerctl";
            prefix = "p";
          }
          {
            provider = "wireplumber";
            prefix = "wp";
          }
        ];
      };

      themes = {
        "ayu-mirage" = {
          style = ''
            * {
              color: #d9d7ce;
              font-family: "JetBrainsMono Nerd Font";
              font-size: 16px;
            }

            #window {
              background-color: transparent;
            }

            #box {
              background-color: #212733;
              border: 2px solid #ffad66;
              padding: 10px;
            }

            #input {
              border-bottom: 2px solid #ffad66;
              margin-bottom: 10px;
              padding: 8px;
            }

            #list {
              /* List container */
            }

            #item {
              padding: 6px;
            }

            #item:selected {
              background-color: #343f4c;
              border-left: 4px solid #ffad66;
            }

            #text {
              margin-left: 10px;
            }
          '';
        };
      };
    };
  };
}

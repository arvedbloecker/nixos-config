# Kanshi defines how displays should be ordered in relation to another. 
# 
# Execute `niri msg outputs` to find the name of the registered screens.
{config, username, pkgs, ...}:
{
  home-manager.users.${username} =
    {
      config, ...
    }:
    {
      services.kanshi = {
        enable = true;
        settings =
          [
            {
              profile = {
                name = "mobile";
                outputs = [
                  {
                    criteria = "Samsung Display Corp. 0x419F Unknown";
                    mode = "2800x1800";
                    status = "enable";
                    scale = 1.0;
                    position = "0,0";
                  }
                ];
              };
            }  
            {
              profile = {
                # Laptop screen below external Screen
                name = "home";
                outputs = [
                  {
                    criteria = "Samsung Display Corp. 0x419F Unknown";
                    mode = "2880x1800";
                    status = "enable";
                    scale = 1.0;
                    position = "${builtins.toString ((2560 - 2880) / 2)},${builtins.toString 1440}";
                  }
                  {
                    criteria = "Lenovo Group Limited Q27q-20 UPP023CY";
                    mode = "2560x1440";
                    status = "enable";
                    scale = 1.0;
                    position = "0,0";
                  }
                ];
              };
            }
          ];
      };
    };
}

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
                    mode = "2880x1800";
                    status = "enable";
                    scale = 1.4;
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
                    scale = 1.5;
                    position = "${builtins.toString ((2560 - 1920) / 2)},${builtins.toString 1440}";
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
            {
              profile = {
                # Laptop screen below external Screen
                name = "sra-lab-pc30";
                outputs = [
                  {
                    criteria = "Samsung Display Corp. 0x419F Unknown";
                    mode = "2880x1800";
                    status = "enable";
                    scale = 1.5;
                    # 1920 comes from 2880 / 1.5 (Scaling) = 1920
                    position = "${builtins.toString ((2560 - 1920) / 2)},${builtins.toString 1440}";
                  }
                  {
                    criteria = "Dell Inc. DELL U2715H GH85D86M06FS";
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

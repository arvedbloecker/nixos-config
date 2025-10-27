{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      wireplumber.extraConfig = {
        "99-disable-mic-auto-adjust" = {
          "wireplumber.settings" = {
            "access.rules" = [
              {
                matches = [
                  { "application.process.binary" = "chrome"; }
                  { "application.process.binary" = "chromium"; }
                  { "application.process.binary" = "firefox"; }
                  { "application.process.binary" = "Discord"; }
                  { "application.process.binary" = "discord"; }
                  { "application.process.binary" = "vesktop"; }
                ];
                actions = {
                  quirks = [ "block-source-volume" ];
                };
              }
            ];
          };
        };
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true; # doesnt truly belong in Audio (Security)
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}

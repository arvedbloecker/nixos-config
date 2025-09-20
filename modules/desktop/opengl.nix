{
  config, pkgs, lib, ...
}:
{
  hardware.opengl.enable = true;

  hardware.opengl.extraPackages = with pkgs; [
    libGL
  ];
}

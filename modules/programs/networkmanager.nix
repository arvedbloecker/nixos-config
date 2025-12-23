{
  config, pkgs, ...
}:
{
  networking.networkmanager.enable = true;

  # networking.wireless.iwd.enable = true;
  # networking.networkmanager.backend = "iwd";

  environment.systemPackages = with pkgs; [
    wireguard-tools
    networkmanager
    networkmanagerapplet
  ];

  networking.firewall.checkReversePath = "loose";
  networking.firewall.allowedUDPPorts = [ 51820 ];
}

{
  config, pkgs, ...
}:
{
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    wireguard-tools
    networkmanager
    networkmanagerapplet
  ];

  networking.firewall.checkReversePath = "loose";
  networking.firewall.allowedUDPPorts = [ 51820 ];
}

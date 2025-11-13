{ lib, pkgs, config, username, ... }:

{
  environment.systemPackages = [
    pkgs.wireshark
  ];

  users.groups.wireshark = {};
  
  users.users.${username}.extraGroups = [ "wireshark" ];

  security.wrappers.dumpcap = {
    owner = "root";
    group = "wireshark";
    capabilities = "cap_net_raw,cap_net_admin=ep";
    source = "${pkgs.wireshark}/bin/dumpcap";
  };
}

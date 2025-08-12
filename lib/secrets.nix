{ lib, config, pkgs, username, ... }:

{
  options.secrets = {
    enable = lib.mkEnableOption "Enable secrets management with SOPS";
    sopsFile = lib.mkOption {
      type = lib.types.path;
      default = ../secrets.yaml;
      description = "Path to the SOPS secrets file";
    };
  };

  config = lib.mkIf config.secrets.enable {
    sops = {
      defaultSopsFile = config.secrets.sopsFile;
      defaultSopsFormat = "yaml";
      age.keyFile = "/home/${username}/.config/sops/age/keys.txt";

      secrets."git/username" = {
        owner = username;
        mode = "0400";
      };

      secrets."git/email" = {
        owner = username;
        mode = "0400";
      };
    };
  };
}

{
  lib,
  config,
  pkgs,
  username,
  ...
}:

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

      secrets.git_username = {
        key = "git/username";
        owner = username;
        mode = "0400";
      };
      secrets.git_email = {
        key = "git/email";
        owner = username;
        mode = "0400";
      };
      secrets.primary_email = {
        key = "user/primary-email";
        owner = username;
      };
    };

    sops.templates = {
      "rbw-config" = {
        content = ''
          {
            "base_url": null,
            "email": "${config.sops.placeholder.primary_email}",
            "identity_url": null,
            "lock_timeout": 3600,
            "pinentry": "${pkgs.pinentry-gnome3}/bin/pinentry"
          }
        '';
        owner = username;
        path = "/home/${username}/.config/rbw/config.json";
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.modules.apps.vscode;
in
{
  options.modules.apps.vscode = {
    enable = lib.mkEnableOption "vscode";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.vscode.enable = true;
    };
  };
}

# VSCode is a gui based texteditor which offers a lot of plugin-support
{ pkgs, username, ... }:
{
  home-manager.users.${username} = { config, ... }: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
  };
}

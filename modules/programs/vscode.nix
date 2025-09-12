# VSCode is a gui based texteditor which offers a lot of plugin-support
{ pkgs, username, ... }:
let
  commonExtensions = with pkgs.vscode-extensions; [
    github.vscode-pull-request-github
    jdinhlife.gruvbox
  ];
in
{
  home-manager.users.${username} = { config, ... }: {
    programs.vscode = {
      enable = true;
      # Use FHS wrapper globally
      package = pkgs.vscode.fhsWithPackages (ps: with ps; [
        python3
        python3Packages.pip
        platformio
        # C/C++ development tools
        gcc
        gdb
        cmake
        pkg-config
        # Serial communication tools
        screen
        minicom
      ]);
      profiles.platformio = {
        extensions = commonExtensions ++ (with pkgs.vscode-extensions; [
          ms-vscode.cpptools
          platformio.platformio-vscode-ide
        ]);
      };
      profiles.typst = {
        extensions = commonExtensions ++ (with pkgs.vscode-extensions; [
          myriad-dreamin.tinymist
        ]);
      };
    };
  };
}

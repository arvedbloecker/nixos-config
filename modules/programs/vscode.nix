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
      package = pkgs.vscode.fhsWithPackages (ps: with ps; [
        python3
        python3Packages.pip
        platformio
        # C/C++ development tools
        gcc
        gdb
        cmake
        pkg-config
      ]);

      profiles.platformio = {
        extensions = commonExtensions ++ (with pkgs.vscode-extensions; [
          ms-vscode.cpptools          # Microsoft C/C++ extension
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

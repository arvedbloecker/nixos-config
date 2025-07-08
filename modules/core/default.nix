{
  imports = [
    ./boot.nix
    ./firmware.nix
    ./locale.nix
    ./networking.nix
    ./power-management.nix
    ./security.nix

    ../../pkgs/system-packages.nix
  ];

  nixpkgs.config.allowUnfree = true;
  programs.firefox.enable = true;
}

{
  imports = [
    ./boot.nix
    ./firmware.nix
    ./locale.nix
    ./networking.nix
    ./security.nix

    ../../pkgs/system-packages.nix
  ];
}

{
  description = "NixOS Configuration System from Arved";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    lib = import ./lib {
      inherit self inputs;
    };
  in
  {
    nixosConfigurations = lib.genHosts {
      magpie-arved = {
        username = "arved";
        userDescription = "Arved Bloecker";
        hostname = "magpie";
      };
    };

    lib = lib;
  };
}


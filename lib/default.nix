{ self, inputs, ... }:

let
  hosts = import ./hosts.nix {
    self = self;
    inputs = inputs;
  };
  systems = import ./systems.nix {
    nixpkgs = inputs.nixpkgs;
  };
  secrets = import ./secrets.nix;
in

{
  inherit (hosts) mkHost genHosts;
  inherit (systems) eachSystem;
  inherit secrets;
}

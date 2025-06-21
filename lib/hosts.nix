{ self, inputs, ... }:
let
  mkHost =
    hostDir:
    {
      arch ? "x86_64-linux",
      hostname ? hostDir,
      username ? "user",
      userDescription ? "Default User",
      hashedPassword ? null,

      gitUsername ? null,
      gitEmail ? null,
      
    }:
    inputs.nixpkgs.lib.nixosSystem {
      system = arch;
      specialArgs = {
        inherit
          inputs
          self
          hostname
          username
          userDescription
          hashedPassword

          gitUsername
          gitEmail
          ;
      };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.niri.nixosModules.niri

        "${self}/default.nix"
        "${self}/hosts/${hostDir}"
      ];
    };
in
{
  mkHost = mkHost;
  genHosts = builtins.mapAttrs mkHost;
}


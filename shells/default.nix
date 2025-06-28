{ pkgs }:
{
  default = import ./shell.nix { inherit pkgs; };
  nix = import ./nix.nix { inherit pkgs; };
  rust = import ./rust.nix { inherit pkgs; };
  
}

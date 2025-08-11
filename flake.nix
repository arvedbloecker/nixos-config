{
  description = "NixOS Configuration System from Arved";

  # Pulls packages from here for nix, home-manager and niri
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

    
    private = if builtins.pathExists ./private.nix 
      then import ./private.nix 
      else {
         gitUsername = "defaulUser";
         gitEmail = "default@example.com";
      };
  in                    
  {
    nixosConfigurations = lib.genHosts {
      magpie-arved = {
        username = "arved";
        userDescription = "Arved Bloecker";
        hostname = "magpie";
        
        # Generate the hashedPassword with mkpasswd
        hashedPassword = "$y$j9T$b2Obca/x4HHLzhGeiTBqr/$G.8GGokLUklJ0qnDKx.3l4pvnQWKNP/X.PROPM0BPIC";

        gitUsername = private.gitUsername;
        gitEmail = private.gitEmail;

        # gitUsername = "arvedbloecker";
        # gitEmail = "git@arvedbloecker.de";
      };
    };
    
    # Development shells in ./shells
    devShells = lib.eachSystem (pkgs: import ./shells { inherit pkgs; });

    lib = lib;
  };
}


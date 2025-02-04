{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      javaEnv = import ./java.nix { inherit pkgs; };
      pythonEnv = import ./python.nix { inherit pkgs; };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration.nix ];
      };

      devShells.${system} = {
        java = javaEnv.devShell; # run "nix develop .#java"
        python = pythonEnv.devShell; # run "nix develop .#python"
      };
    };
}

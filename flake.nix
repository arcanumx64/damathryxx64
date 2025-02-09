{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    javaEnv = import ./modules/shells/java.nix {inherit pkgs;};
    pythonEnv = import ./modules/shells/python.nix {inherit pkgs;};
  in {
    nixosConfigurations.nixos =
      nixpkgs.lib.nixosSystem {modules = [./modules/configuration.nix];};

    devShells.${system} = {
      java = javaEnv.devShell;
      python = pythonEnv.devShell;
    };
  };
}

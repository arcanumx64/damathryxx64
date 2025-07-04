{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:arcanumx64/nixos-hardware/master";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pythonEnv = import ./modules/shells/python.nix {inherit pkgs;};
    devopsEnv = import ./modules/shells/devops.nix {inherit pkgs;};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        nixos-hardware.nixosModules.asus-zenbook-ux540
        ./modules/configuration.nix
      ];
    };

    devShells.${system} = {
      python = pythonEnv.devShell;
      devops = devopsEnv.devShell;
    };
  };
}

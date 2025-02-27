{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    javaEnv = import ./modules/shells/java.nix {inherit pkgs;};
    pythonEnv = import ./modules/shells/python.nix {inherit pkgs;};
    awsEnv = import ./modules/shells/aws.nix {inherit pkgs;};
    scalaEnv = import ./modules/shells/scala.nix {inherit pkgs;};
    ansibleEnv = import ./modules/shells/ansible.nix {inherit pkgs;};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        nixos-hardware.nixosModules.lenovo-legion-16ach6h-nvidia
        ./modules/configuration.nix
      ];
    };

    devShells.${system} = {
      java = javaEnv.devShell;
      python = pythonEnv.devShell;
      aws = awsEnv.devShell;
      scala = scalaEnv.devShell;
      ansible = ansibleEnv.devShell;
    };
  };
}

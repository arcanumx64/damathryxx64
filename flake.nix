{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-wsl,
  }: let
    system = "x86_64-linux";
    pythonEnv = import ./modules/shells/python.nix {inherit nixpkgs;};
    devopsEnv = import ./modules/shells/devops.nix {inherit nixpkgs;};
    hostName = "nixos";
    userName = "damathryxx64";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          nixos-wsl.nixosModules.default
          ({pkgs, ...}:
            import ./modules/configuration.nix {
              inherit system nixpkgs hostName userName pkgs;
            })
          {
            wsl = {
              enable = true;
              wslConf.automount.root = "/mnt";
              defaultUser = userName;
              startMenuLaunchers = true;
            };
            system.stateVersion = "25.05";
          }
        ];
      };
    };

    devShells.${system} = {
      python = pythonEnv.devShell;
      devops = devopsEnv.devShell;
    };

    formatter.${system} = pkgs.nixpkgs-fmt;
  };
}

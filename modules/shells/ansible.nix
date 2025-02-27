# ansible.nix
{pkgs ? import <nixpkgs> {}}: {
  allowUnfree = true;
  devShell = pkgs.mkShell {
    buildInputs = with pkgs; [
      python311Packages.ansible-core
    ];

    shellHook = ''
      echo "Ansible environment ready!"
    '';
  };
}

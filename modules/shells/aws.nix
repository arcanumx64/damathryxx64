# aws.nix
{pkgs ? import <nixpkgs> {}}: {
  allowUnfree = true;
  devShell = pkgs.mkShell {
    buildInputs = with pkgs; [
      awsls
      awscli2
      eksctl
      kubectl
      terraform
    ];

    shellHook = ''
      echo "AWS CLI environment ready!"
    '';
  };
}

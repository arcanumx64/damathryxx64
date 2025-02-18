# scala.nix
{pkgs ? import <nixpkgs> {}}: {
  devShell = pkgs.mkShell {
    buildInputs = with pkgs; [
      scala_2_13
      sbt
    ];
  };
}

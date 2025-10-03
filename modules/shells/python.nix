# python.nix
{
  pkgs ? import <nixpkgs> {},
  nixpkgs ? null,
}: let
  usedPkgs =
    if nixpkgs != null
    then nixpkgs
    else pkgs;
in {
  devShell = usedPkgs.mkShell {
    buildInputs = with usedPkgs.python312Packages; [
      usedPkgs.python312
      virtualenv
      pip
      setuptools
      wheel
      ipython
      black
      flake8
      mypy
      requests
      numpy
      pandas
      matplotlib
      pytest
    ];

    shellHook = ''
      if [ ! -d ".venv" ]; then
        python -m venv .venv
        echo "Virtual environment created in .venv"
      fi
      source .venv/bin/activate
      echo "Python dev environment activated!"
    '';
  };
}

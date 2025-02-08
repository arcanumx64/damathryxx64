# python.nix

{ pkgs ? import <nixpkgs> {} }:

{
  devShell = pkgs.mkShell {
    buildInputs = with pkgs.python311Packages; [
      pkgs.python311
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

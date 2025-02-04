# python.nix

{ pkgs ? import <nixpkgs> {} }:

{
  # Development environment configuraton
  devShell = pkgs.mkShell {
    buildInputs = with pkgs; [
      python311  # Use the latest Python version
      python311Packages.virtualenv  # Virtual environments
      python311Packages.pip  # Package manager
      python311Packages.setuptools  # Build system
      python311Packages.wheel  # For packaging
      python311Packages.ipython  # Interactive shell
      python311Packages.black  # Code formatter
      python311Packages.flake8  # Linter
      python311Packages.mypy  # Type checker
      python311Packages.requests  # HTTP library
      python311Packages.numpy  # Numeric computing
      python311Packages.pandas  # Data handling
      python311Packages.matplotlib  # Plotting
      python311Packages.pytest  # Testing
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

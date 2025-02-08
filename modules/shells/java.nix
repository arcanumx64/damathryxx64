# java.nix
{ pkgs ? import <nixpkgs> {} }:

{
  devShell = pkgs.mkShell {
    buildInputs = with pkgs; [
      # JDK 21 (Latest LTS version) as of Feb 6th 2025
      jdk21

      maven
      gradle

      jdt-language-server

      visualvm
      jmeter

      checkstyle
      pmd
    ];

    shellHook = ''
      export JAVA_HOME=${pkgs.jdk21}/lib/openjdk
      export MAVEN_OPTS="-Xmx2048m"
      export GRADLE_OPTS="-Xmx2048m"

      echo "Java development environment ready!"
      echo "Java version: $(java --version)"
      echo "Maven version: $(mvn --version)"
      echo "Gradle version: $(gradle --version)"
    '';
  };
}
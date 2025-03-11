{pkgs ? import <nixpkgs> {}}: {
  allowUnfree = true;
  devShell = pkgs.mkShell {
    buildInputs = with pkgs; [
      # AWS Tools
      awscli2
      awsls
      eksctl
      amazon-ecr-credential-helper
      ssm-session-manager-plugin
      aws-vault

      # IaC
      terraform
      terraform-ls
      terragrunt

      # DevOps Tools
      docker
      docker-compose
      kubectl
      kubectx
      kubernetes-helm
      k9s
      kustomize
      argocd
      stern
      skaffold

      # Git and CI/CD
      git
      gh
      pre-commit

      # Monitoring and Observability
      grafana-loki
      prometheus

      # Shell and CLI Enhancements
      zsh
      oh-my-zsh
      starship
      fzf
      zoxide
      bat
      eza
      fd
      ripgrep
      jq
      yq
      tmux
      direnv
      tree

      # Development Tools
      python311
      python311Packages.pip
      python311Packages.pylint
      python311Packages.black
      python311Packages.isort
      python311Packages.pytest
      python311Packages.boto3
      python311Packages.ansible-core
    ];

    shellHook = ''
      # Set up environment variables
      export SHELL=zsh
      export AWS_PAGER=""
      export EDITOR="code -w"
      export PATH="$HOME/.local/bin:$PATH"

      # Print welcome message
      echo ""
      echo "🚀 DevOps Nix Shell Loaded! 🚀"
      echo "============================="
      echo "AWS Tools: awscli2, aws-vault, terraform, etc."
      echo "DevOps Tools: docker, kubectl, kubernetes-helm, etc."
      echo "Fancy CLI: zsh, starship, fzf, zoxide, etc."
      echo ""
      echo "Configured tools:"
      echo "- Zsh with Oh-My-Zsh"
      echo "- Starship prompt"
      echo "- Tmux with sensible defaults"
      echo "- Git with VSCode as editor"
      echo "- Direnv for environment handling"
      echo ""
      echo "============================="

      # Start ZSH if it exists
      if command -v zsh &> /dev/null; then
        exec zsh -c "source ~/.zshrc; exec zsh"
        # TODO: add config files for cli tools.
      fi
    '';
  };
}

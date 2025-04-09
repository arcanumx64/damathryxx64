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
      packer

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
      zsh-autosuggestions
      zsh-syntax-highlighting
      starship
      fzf
      zoxide
      bat
      eza
      fd
      ripgrep
      jq
      yq
      direnv
      tree

      # Fonts
      cascadia-code
      (nerdfonts.override {fonts = ["CascadiaCode"];})

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
        # Create a temporary home directory for shell-specific configurations
        export TEMP_HOME="$(mktemp -d)"
        export ZDOTDIR="$TEMP_HOME"
        export XDG_CONFIG_HOME="$TEMP_HOME/.config"
        export XDG_DATA_HOME="$TEMP_HOME/.local/share"
        export XDG_CACHE_HOME="$TEMP_HOME/.cache"

        # Create completion directories
        mkdir -p "$ZDOTDIR/completions"
        mkdir -p "$ZDOTDIR/site-functions"

        # Set up environment variables
        export SHELL=zsh
        export AWS_PAGER=""
        export EDITOR="code -w"
        export PATH="$HOME/.local/bin:$PATH"
        export LC_ALL=C.UTF-8
        export LANG=C.UTF-8

        # Create ZSH configuration directory
        mkdir -p "$ZDOTDIR"
        mkdir -p "$XDG_CONFIG_HOME/starship"
        mkdir -p "$ZDOTDIR/.zsh"

        # Create an Oh-My-Zsh stub directly in the temp directory
        mkdir -p "$ZDOTDIR/oh-my-zsh/themes"
        mkdir -p "$ZDOTDIR/oh-my-zsh/custom/plugins"

        # Copy core completions from Nixpkgs
        # Link to standard locations for built-in completions from packages
        mkdir -p "$ZDOTDIR/site-functions"
        ln -sf "${pkgs.zsh}/share/zsh/site-functions/"* "$ZDOTDIR/site-functions/" 2>/dev/null || true

        # Dynamically enable completions for all packages in buildInputs
        for pkg in $NIX_BUILD_INPUTS; do
            if [ -d "$pkg/share/zsh/site-functions" ]; then
                ln -sf "$pkg/share/zsh/site-functions/"* "$ZDOTDIR/site-functions/" 2>/dev/null || true
            fi
            if [ -d "$pkg/share/zsh/vendor-completions" ]; then
                ln -sf "$pkg/share/zsh/vendor-completions/"* "$ZDOTDIR/site-functions/" 2>/dev/null || true
            fi
            if [ -d "$pkg/share/bash-completion/completions" ]; then
                for f in "$pkg/share/bash-completion/completions/"*; do
                    if [ -f "$f" ]; then
                        bn=$(basename "$f")
                        # Create an adapter for bash completions
                        echo "#compdef $bn" > "$ZDOTDIR/site-functions/_$bn"
                        echo "autoload -U +X bashcompinit && bashcompinit" >> "$ZDOTDIR/site-functions/_$bn"
                        echo "source $f" >> "$ZDOTDIR/site-functions/_$bn"
                    fi
                done
            fi
        done

        # Copy agnoster theme
        cp "${pkgs.oh-my-zsh}/share/oh-my-zsh/themes/agnoster.zsh-theme" "$ZDOTDIR/oh-my-zsh/themes/"

        # Create ZSH configuration
        cat > "$ZDOTDIR/.zshrc" << 'EOF'
        # Add completions directory to fpath
        fpath=("$ZDOTDIR/site-functions" "$ZDOTDIR/completions" $fpath)

        # Initialize bash completion support for ZSH
        autoload -U +X bashcompinit && bashcompinit

        # Initialize completion system first
        autoload -Uz compinit
        compinit -u

        # Oh-My-Zsh Configuration
        export ZSH="$ZDOTDIR/oh-my-zsh"
        ZSH_THEME="agnoster"

        # Set up basic Oh-My-Zsh configuration
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/lib/completion.zsh
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/lib/history.zsh
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/lib/key-bindings.zsh
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/lib/theme-and-appearance.zsh
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/lib/git.zsh
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/themes/agnoster.zsh-theme

        # Load plugin functions from oh-my-zsh
        for plugin in git docker kubectl fzf terraform history-substring-search zoxide jira debian dnf systemd yum aws eza; do
            if [[ -f ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/$plugin/$plugin.plugin.zsh ]]; then
                source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/$plugin/$plugin.plugin.zsh
            fi
        done

        # For Kubectl alias
        if type kubectl &>/dev/null; then
            source <(kubectl completion zsh)
            compdef k=kubectl
        fi

        # For Terraform alias
        if type terraform &>/dev/null; then
            complete -o nospace -C $(which terraform) terraform
            compdef tf=terraform
        fi

        # Autosuggestions & Syntax Highlighting
        source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

        # FZF Configuration
        source ${pkgs.fzf}/share/fzf/completion.zsh
        source ${pkgs.fzf}/share/fzf/key-bindings.zsh

        # Enhanced FZF configuration
        export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --style=numbers --color=always --line-range :500 {}'"
        export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

        # Aliases
        alias ls="eza --icons --git"
        alias ll="eza --icons --git -la"
        alias lt="eza --tree --icons --git"
        alias cat="bat --theme=Dracula"
        alias cd="z"
        alias tf="terraform"
        alias k="kubectl"
        alias kx="kubectx"
        alias kn="kubens"

        # History configuration
        HISTSIZE=10000
        SAVEHIST=10000
        HISTFILE="$ZDOTDIR/.zsh_history"
        setopt SHARE_HISTORY
        setopt HIST_IGNORE_ALL_DUPS
        setopt HIST_FIND_NO_DUPS
        setopt HIST_REDUCE_BLANKS

        # Initialize starship prompt
        eval "$(starship init zsh)"

        # Initialize direnv
        eval "$(direnv hook zsh)"

        # Initialize zoxide
        eval "$(zoxide init zsh)"
        EOF

        # Create Starship configuration
        mkdir -p "$XDG_CONFIG_HOME/starship"
        cat > "$XDG_CONFIG_HOME/starship/starship.toml" << 'EOF'
        format = """
        [](#3B4252)\
        $username\
        $hostname\
        $directory\
        $git_branch\
        $git_status\
        $kubernetes\
        $aws\
        $terraform\
        $python\
        $docker_context\
        $cmd_duration\
        $time\
        $line_break\
        $character\
        """

        [username]
        show_always = true
        style_user = "fg:#81A1C1 bg:#3B4252"
        style_root = "fg:#BF616A bg:#3B4252"
        format = '[$user ]($style)'

        [hostname]
        ssh_only = false
        style = "fg:#EBCB8B bg:#3B4252"
        format = '[@$hostname ]($style)'

        [directory]
        style = "fg:#A3BE8C bg:#3B4252"
        format = '[$path ]($style)'
        truncation_length = 3
        truncation_symbol = "…/"

        [git_branch]
        style = "fg:#B48EAD bg:#3B4252"
        format = '[$symbol$branch ]($style)'

        [git_status]
        style = "fg:#BF616A bg:#3B4252"
        format = '[$all_status$ahead_behind ]($style)'

        [kubernetes]
        style = "fg:#88C0D0 bg:#3B4252"
        format = '[$symbol$context( \($namespace\)) ]($style)'
        disabled = false

        [aws]
        style = "fg:#D08770 bg:#3B4252"
        format = '[$symbol$profile( \($region\)) ]($style)'

        [terraform]
        style = "fg:#5E81AC bg:#3B4252"
        format = '[$symbol$workspace ]($style)'

        [python]
        style = "fg:#EBCB8B bg:#3B4252"
        format = '[$symbol$version( \($virtualenv\)) ]($style)'

        [docker_context]
        style = "fg:#81A1C1 bg:#3B4252"
        format = '[$symbol$context ]($style)'

        [cmd_duration]
        style = "fg:#D08770 bg:#3B4252"
        format = '[$duration ]($style)'
        min_time = 500

        [time]
        style = "fg:#4C566A bg:#3B4252"
        format = '[$time ]($style)'
        disabled = false
        time_format = "%H:%M"

        [character]
        success_symbol = "[λ](bold green)"
        error_symbol = "[λ](bold red)"
        vimcmd_symbol = "[λ](bold blue)"
        EOF

        # Define help function directly in .zshrc
        cat >> "$ZDOTDIR/.zshrc" << 'EOF'

        # DevOps Help Function
        function help-devops() {
        echo "\033[1;36m📚 DevOps Shell Quick Reference:\033[0m"
        echo ""
        echo "\033[1;33mCloud & Infrastructure:\033[0m"
        echo "  tf               → Terraform shorthand"
        echo "  aws-login        → Configure AWS credentials"
        echo "  aws s3 ls        → List S3 buckets"
        echo ""
        echo "\033[1;33mKubernetes:\033[0m"
        echo "  k                → kubectl shorthand"
        echo "  kx               → switch context"
        echo "  kn               → switch namespace"
        echo "  k9s              → K8s TUI"
        echo ""
        echo "\033[1;33mSearch & Navigation:\033[0m"
        echo "  Ctrl+R           → Search command history"
        echo "  Ctrl+T           → Find files"
        echo "  Alt+C            → Jump to directory"
        echo ""
        echo "\033[1;33mShell Enhancements:\033[0m"
        echo "  ls, ll, lt       → Enhanced file listing"
        echo "  z <dir>          → Smart directory navigation"
        }
        EOF

        # Create required files and directories for ZSH
        mkdir -p "$ZDOTDIR/.zsh"
        mkdir -p "$XDG_CACHE_HOME/zsh"
        touch "$ZDOTDIR/.zsh_history"

        # Start ZSH
        if command -v zsh &> /dev/null; then
            exec zsh -i
        fi
    '';
  };
}

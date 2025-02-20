{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bat
    fd
    fzf
    git
    htop
    jq
    ripgrep
    starship
    tmux
    zsh
    docker
    kubectl
    terraform
    awscli2
    python3
    nodejs
    go
    kitty
  ];

  fonts = {
    fonts = with pkgs; [
      cascadia-code
      (nerdfonts.override {fonts = ["CascadiaCode"];})
    ];
    fontconfig = {
      defaultFonts = {
        monospace = ["CascadiaCode Nerd Font"];
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "docker"
        "kubectl"
        "fzf"
        "terraform"
        "tmux"
        "history-substring-search"
      ];
    };
  };

  programs.starship = {
    enable = true;
  };

  environment.pathsToLink = ["/share/zsh"];
  environment.shells = [pkgs.zsh];
  users.defaultUserShell = pkgs.zsh;
}

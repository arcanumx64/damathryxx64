{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
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

    shellAliases = {
      ls = "eza -lA";
    };
  };

  programs.starship = {
    enable = true;
  };

  environment.pathsToLink = ["/share/zsh"];
  environment.shells = [pkgs.zsh];
  users.defaultUserShell = pkgs.zsh;
}

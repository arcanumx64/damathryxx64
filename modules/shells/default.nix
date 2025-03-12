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
        "zoxide"
        "jira"
        "debian"
        "dnf"
        "systemd"
        "yum"
        "aws"
        "eza"
        "gh"
      ];
      theme = "agnoster";
    };
  };

  programs = {
    starship = {
      enable = true;
    };
  };

  environment.pathsToLink = ["/share/zsh"];
  environment.shells = [pkgs.zsh];
  users.defaultUserShell = pkgs.zsh;
}

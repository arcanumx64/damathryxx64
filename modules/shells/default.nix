{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.caskaydia-cove
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
        "fzf"
        "terraform"
        "history-substring-search"
        "zoxide"
        "jira"
        "systemd"
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

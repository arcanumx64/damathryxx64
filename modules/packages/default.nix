{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # CLI Development Tools
    vim
    gcc
    gh
    nixd
    clang
    git

    # CLI Utilities
    tree
    unzip
    eza # Modern replacement for ls
    zoxide # Directory navigation
    bat # Modern replacement for cat
    fd # Modern replacement for find
    ripgrep # Modern replacement for grep
    fzf # Fuzzy finder
    ripgrep
    starship

    htop
    fastfetch # System information display
    killall
    jq # JSON processor

    # Network Tools
    networkmanagerapplet
    curl
    wget

    # System Management & Monitoring
    inxi # System information
    duf # Disk usage analyzer
    cpufrequtils
    pciutils

    xarchiver # Archive manager

    # Terminal & Shell
    alejandra # Nix formatter

    # System Libraries & Dependencies
    openssl
    libappindicator
    libnotify

    # Fonts
    cascadia-code
    nerd-fonts.fira-code

    # AI & Development Tools
    ollama # Local LLM runner

    # Download Tools
    yt-dlp # Video downloader
  ];
}

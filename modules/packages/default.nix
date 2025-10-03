{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # CLI Development Tools
    vim
    gcc
    nixd
    clang
    gh

    # CLI Utilities
    tree
    unzip
    fd # Modern replacement for find
    ripgrep # Modern replacement for grep
    ripgrep
    fzf
    eza

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

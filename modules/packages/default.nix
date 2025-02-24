{pkgs, ...}: {
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
    tmux

    htop
    fastfetch # System information display
    killall
    jq # JSON processor

    # Text Editors & IDEs
    vscode
    kitty

    # Network Tools
    networkmanagerapplet
    curl
    wget

    # System Management & Monitoring
    gnome-tweaks
    gnome-system-monitor
    inxi # System information
    duf # Disk usage analyzer
    btrfs-progs # BTRFS filesystem tools
    cpufrequtils
    pciutils
    autorandr # Multi-monitor management

    # Office & Document Tools
    libreoffice-qt6-fresh
    xarchiver # Archive manager

    # Media Tools
    ffmpeg # Media converter
    eog # Image viewer
    pamixer # CLI audio control
    pavucontrol # GUI audio control
    playerctl # Media player control

    # GNOME Specific
    mutter # GNOME window manager
    gnomeExtensions.display-scale-switcher
    gnomeExtensions.hot-edge
    glib # For gsettings
    gsettings-qt
    polkit_gnome # Authentication agent

    evince # document viewer
    gedit # text editor
    gnome-characters
    gnome-music
    gnome-photos
    totem # video player

    # Terminal & Shell
    alejandra # Nix formatter

    # System Libraries & Dependencies
    openssl
    libappindicator
    libnotify
    xdg-user-dirs
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-user-dirs-gtk

    # Fonts
    cascadia-code
    fira-code-nerdfont

    # AI & Development Tools
    ollama # Local LLM runner

    # Browsers
    google-chrome

    # Download Tools
    yt-dlp # Video downloader

    # Utility GUI Apps
    yad # GUI dialog tool
  ];
}

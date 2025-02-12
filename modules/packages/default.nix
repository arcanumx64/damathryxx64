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
    curl
    wget
    fastfetch # System information display
    killall
    jq # JSON processor

    # Text Editors & IDEs
    vscode

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
    imagemagick # Image manipulation
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

    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    evince # document viewer
    geary # email reader
    gedit # text editor
    gnome-characters
    gnome-music
    gnome-photos
    gnome-terminal
    gnome-tour
    hitori # sudoku game
    iagno # go game
    tali # poker game
    totem # video player

    # Terminal & Shell
    alejandra # Nix formatter

    # System Libraries & Dependencies
    openssl
    libappindicator
    libnotify
    xdg-user-dirs
    xdg-utils

    # Fonts
    cascadia-code

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

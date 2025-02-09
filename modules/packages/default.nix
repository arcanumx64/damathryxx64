{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
    google-chrome
    vscode
    gcc
    gh
    nixd
    fastfetch
    tree
    unzip
    libreoffice-qt6-fresh
    ollama
    mutter
    gnomeExtensions.display-scale-switcher
    gnomeExtensions.hot-edge
    gnome-tweaks
    autorandr
    openssl
    cascadia-code
    docker
    docker-client
    nvidia-container-toolkit
    nixfmt-rfc-style
  ];
}

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
  ];
}

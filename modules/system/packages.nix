{
  config,
  lib,
  pkgs,
  ...
}: let
  system = with pkgs; [
    vim
    btop
    htop
    eza
    bat
    fzf
    curl
    wget
    unzip
    rsync
    aria2
    kdePackages.ark
    git
  ];

  media = with pkgs; [
    mpv
    ffmpeg
    gnome-photos
    qbittorrent-enhanced
  ];

  development = with pkgs; [
    lazygit
    alejandra
    nixd
    nixpkgs-fmt
    nixfmt
    jdk
    jdt-language-server
  ];

  allPackages = system ++ media ++ development;
in {
  environment.systemPackages = allPackages;
}

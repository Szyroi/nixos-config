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
    neofetch
    ripgrep
    fd
    eza
    bat
    fzf
    git
    curl
    wget
    unzip
    rsync
    aria2
    kdePackages.ark
  ];

  media = with pkgs; [
    mpv
    ffmpeg
    imagemagick
    qbittorrent-enhanced
  ];

  development = with pkgs; [
    lazygit
    alejandra
    nixd
    nixpkgs-fmt
  ];

  allPackages = system ++ media ++ development;
in {
  environment.systemPackages = allPackages;
}

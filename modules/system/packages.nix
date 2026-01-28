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
    aria2
    kdePackages.ark
  ];

  media = with pkgs; [
    mpv
    ffmpeg
    loupe
    qbittorrent-enhanced
  ];

  development = with pkgs; [
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

{pkgs}: {
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
  ];

  media = with pkgs; [
    mpv
    ffmpeg
    imagemagick
  ];

  development = with pkgs; [
    lazygit
    alejandra
    nixd
    nixpkgs-fmt
  ];
}

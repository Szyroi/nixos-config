{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mpv
    ffmpeg
    loupe
    qbittorrent-enhanced
    libreoffice-stable
    gnome-calendar
    gnome-calculator
    ausweisapp
    parabolic
    cliamp
    zathura
    texliveFull
    texstudio
    jetbrains.idea
  ];
}

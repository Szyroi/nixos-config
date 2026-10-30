{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mpv
    loupe
    qbittorrent-enhanced
    libreoffice-stable
    gnome-calendar
    gnome-calculator
    ausweisapp
    pavucontrol
    texliveFull
    texstudio
    jetbrains.idea
    networkmanagerapplet
  ];
}

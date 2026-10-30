{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim
    iotop
    powertop
    btop
    bat
    curl
    wget
    unar
    man-pages
    man-pages-posix
    brightnessctl
    wl-clipboard
    playerctl
    cliamp
    zathura
  ];
}

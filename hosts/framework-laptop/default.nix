{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../../devices/framework-laptop.nix

    ../../profiles/base.nix
    ../../profiles/laptop.nix
    ../../profiles/workstation.nix
    ../../profiles/gaming.nix
  ];

  programs.qylock = {
    enable = true;
    theme = "pixel-hollowknight";
    sddm.enable = true;
    quickshell.enable = true;
  };

  environment.defaultPackages = with pkgs; [
    easyroam-connect-desktop
  ];

  networking.hostName = "framework";

  system.stateVersion = "26.11";
}

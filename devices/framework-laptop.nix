{
  username,
  pkgs,
  ...
}: {
  home-manager.users.${username}.imports = [
    ../modules/home-manager/desktop/hyprland/framework-laptop.nix
  ];

  hardware.cpu.amd.updateMicrocode = true;
  services.xserver.videoDrivers = ["amdgpu"];

  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  services.fprintd.enable = true;
  security.pam.services = {
    login = {
      fprintAuth = true;
      enableGnomeKeyring = true;
    };
    hyprland = {
      enableGnomeKeyring = true;
    };
    sddm.fprintAuth = true;
    sudo.fprintAuth = true;
  };
}

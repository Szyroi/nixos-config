{
  pkgs,
  config,
  username,
  ...
}: {
  home-manager.users.${username}.imports = [
    ../modules/home-manager/desktop/hyprland/desktop.nix
  ];

  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
    liquidctl
    lm_sensors
  ];

  hardware.cpu.amd.updateMicrocode = true;
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = true;
    nvidiaPersistenced = false;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  powerManagement = {
    cpuFreqGovernor = "powersave";
    cpufreq = {
      min = 425000; # 425 MHz
      max = 5200000; # 5.2 GHz
    };
  };

  services.auto-epp = {
    enable = true;
    settings = {
      Settings = {
        epp_state_for_AC = "balance_performance";
        epp_state_for_BAT = "balance_power";
      };
    };
  };

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
    "nvidia.NVreg_EnableGpuFirmware=0"
    "pcie_aspm=off"
    "nvme_core.default_ps_max_latency_us=0"
  ];
}

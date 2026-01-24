{
  config,
  pkgs,
  username,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/packages.nix
  ];
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      max-jobs = "auto";
      cores = 0;
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment.sessionVariables = {
    # Wayland Core
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";

    # NVIDIA spezifisch

    # Desktop Session
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";

    # Input Method
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
  };

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth.enable = true;
    steam-hardware.enable = true;
  };

  services = {
    xserver = {
      videoDriver = "nvidia";
    };
    dbus.enable = true;
    udisks2.enable = true;
    openssh.enable = true;
    blueman.enable = true;
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
        hplipWithPlugin
        gutenprint
      ];
    };

    xserver = {
      enable = true;
      xkb = {
        layout = "de";
        variant = "";
      };
    };

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --asterisks -t -c ${config.programs.hyprland.package}/bin/start-hyprland";
          user = "greeter";
        };
      };
    };
  };

  users.users.greeter = {
    isSystemUser = true;
    group = "greeter";
    home = "/var/lib/greeter";
    createHome = true;
  };
  users.groups.greeter = {};

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [80 443 22];
      allowedUDPPorts = [53];
    };
  };

  time.timeZone = "Europe/Berlin";
  console.keyMap = "de";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
    };
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        kdePackages.fcitx5-qt
      ];
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "User";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  fileSystems."/run/media/${username}/windows3" = {
    device = "/dev/nvme0n1p3";
    fsType = "ntfs3";
    options = [
      "defaults"
      "uid=1000"
      "gid=1000"
      "dmask=027"
      "fmask=137"
    ];
  };

  fileSystems."/run/media/${username}/windows5" = {
    device = "/dev/nvme0n1p5";
    fsType = "ntfs3";
    options = [
      "defaults"
      "uid=1000"
      "gid=1000"
      "dmask=027"
      "fmask=137"
    ];
  };

  xdg.mime = {
    enable = true;
    addedAssociations = {
      "text/plain" = "kate.desktop";
    };
  };

  programs = {
    firefox.enable = true;
    thunar.enable = true;
    xfconf.enable = true;
    hyprland = {
      enable = true;
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [protonup-ng];
    };
    nix-ld.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  system.stateVersion = "25.05";
}

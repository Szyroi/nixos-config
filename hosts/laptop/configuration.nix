{
  config,
  pkgs,
  username,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/packages.nix
    ../../modules/system/git.nix
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

    # Desktop Session
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";

    # Input Method
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";

    JAVA_HOME = "${pkgs.jdk.home}";
  };

  services.dbus.enable = true;
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  services.xserver.enable = true;
  services.xserver.videoDrivers = ["amd"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
        22
      ];
      allowedUDPPorts = [53];
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
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

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "${pkgs.where-is-my-sddm-theme.override {variants = ["qt5"];}}/share/sddm/themes/where_is_my_sddm_theme_qt5";
  };

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  console.keyMap = "de";

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
      hplipWithPlugin
      gutenprint
    ];
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = "User";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  xdg.mime = {
    enable = true;
    addedAssociations = {
      "text/plain" = "kate.desktop"; # Text-Dateien
    };
    defaultApplications = {
      "inode/directory" = "dolphin.desktop";
    };
  };

  programs.firefox.enable = true;
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [
      protonup-ng # Für Proton-GE
    ];
  };

  hardware.steam-hardware.enable = true;

  programs.nix-ld.enable = true;

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}

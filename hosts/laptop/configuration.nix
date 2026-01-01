{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Garbage Collector
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 7d";
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GDK_BACKEND = "wayland";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    MOZ_ENABLE_WAYLAND = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
  };

  services.dbus.enable = true;
  security.polkit.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      kdePackages.fcitx5-qt
    ];
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  #   services.displayManager.sddm.wayland.enable = true;
  services.xserver.enable = true;
  services.displayManager.ly = {
    enable = true;
    x11Support = true;
    settings = {
      session = "/home/szyroi/.config/ly/session.sh";
      tty = 1;
      theme = "solarized_dark";
    };
  };
  services.displayManager.sddm.enable = false;
  #   services.displayManager.sddm.theme = "where_is_my_sddm_theme";

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
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  users.users.szyroi = {
    isNormalUser = true;
    description = "szyroi";
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
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
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

  environment.systemPackages = with pkgs; [
    vim
    btop
    wget
    git
    bat
    wofi
    fzf
    curl
    unzip
    lazygit
    ripgrep
    fd
    mpv
    ly
    nixfmt-rfc-style
    nil
    nixd
    qalculate-gtk
    hplip
    polkit
    ntfs3g
    gnome-keyring
    kdePackages.xdg-desktop-portal-kde
  ];

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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = [ "amd" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "25.05";
}

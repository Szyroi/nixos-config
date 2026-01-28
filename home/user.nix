{
  pkgs,
  username,
  extraImports ? [],
  ...
}: {
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  imports =
    [
      ../modules/home/starship.nix
      ../modules/home/kitty.nix
      ../modules/home/sh.nix
      ../modules/home/fastfetch.nix
      ../modules/home/hyprland.nix
      ../modules/home/nixvim.nix
      ../modules/home/zed.nix
      ../modules/home/wofi.nix
      # inputs.zen-browser.homeModules.beta
      # inputs.zen-browser.homeModules.twilight
      # inputs.zen-browser.homeModules.twilight-official
    ]
    ++ extraImports;

  programs = {
    quickshell = {
      enable = true;
      activeConfig = "~/.config/quickshell/shell.qml";
    };
  };

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    papirus-icon-theme
    bibata-cursors
    easyeffects
    obsidian
    vesktop
    wl-clipboard
    quickshell
    libsForQt5.qt5.qtdeclarative
    syncthing
    anki
    bitwarden-desktop
  ];

  # === Cursor Theme ===
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    font = {
      name = "Inter";
      package = pkgs.inter;
      size = 11;
    };
  };

  home.file = {
  };

  programs.home-manager.enable = true;
}

{
  pkgs,
  lib,
  ...
}: {
  gtk = {
    enable = true;

    gtk3.extraConfig."gtk-application-prefer-dark-theme" = 1;
    gtk4.extraConfig."gtk-application-prefer-dark-theme" = 1;
  };

  qt = {
    enable = true;
    platformTheme.name = lib.mkDefault "gtk";
  };

  xdg.desktopEntries.thunar = {
    name = "Thunar";
    exec = "env GTK_THEME=Colloid-Dark thunar %U";
    icon = "org.xfce.thunar";
    categories = ["System" "FileManager"];
    mimeType = ["inode/directory"];
  };

  home.packages = with pkgs; [
    adwaita-icon-theme
    colloid-icon-theme
  ];
}

{pkgs, ...}: {
  stylix = {
    enable = true;
    targets = {
      kmscon.enable = false;
    };
    image = ../../home-manager/desktop/wallpapers/WP11.png;

    polarity = "dark";

    base16Scheme = {
      base00 = "111113";
      base01 = "1a1b1f";
      base02 = "23242a";
      base03 = "333232";

      base04 = "8754f2";
      base05 = "ffffff";
      base06 = "f2f6fa";
      base07 = "ffffff";

      base08 = "6346ff";
      base09 = "43aaf9";
      base0A = "43aaf9";
      base0B = "bf7af0";
      base0C = "43aaf9";
      base0D = "8754f2";
      base0E = "f75f8f";
      base0F = "e61f44";
    };

    fonts = {
      sansSerif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      serif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      sizes = {
        applications = 11;
        terminal = 12;
        desktop = 11;
        popups = 11;
      };
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}

{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # === Bash ===

  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nix#desktop";
    };

    bashrcExtra = ''
      if command -v fastfetch >/dev/null 2>&1; then
        fastfetch
      fi
      eval "$(starship init bash)"
    '';
  };

  # === Fish ===

  programs.fish = {
    enable = true;
    shellAliases = {
      uwu = "sudo";
      rebuild = "sudo nixos-rebuild switch --flake ~/nix#desktop";
      update = "sudo nix flake update --flake ~/nix";
    };
    shellInit = ''
      set -g fish_greeting ""
      starship init fish | source
    '';
  };
}

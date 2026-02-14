{...}: {
  imports = [
    ./programs/git.nix
    ./programs/zed.nix
    ./programs/zen.nix
    ./programs/kitty.nix
    ./programs/starship.nix
    ./programs/fastfetch.nix
    ./programs/nixvim.nix
    ./programs/wofi.nix
    ./theme/theme.nix
    ./theme/gtk.nix
    ./wm/hyprland.nix
    ./shell/sh.nix
    ./nixpkgs/nixpkgs-config.nix
  ];
}

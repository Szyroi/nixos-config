{pkgs}: let
  clangd-nix = pkgs.writeShellScriptBin "clangd-nix" ''
    exec ${pkgs.clang-tools}/bin/clangd \
      --query-driver="${pkgs.clang}/bin/clang" \
      "$@"
  '';
in
  pkgs.mkShell {
    packages = with pkgs; [
      gcc
      clang
      clang-tools
      gnumake
      cmake
      ninja
      gdb
      bear
      clangd-nix
    ];

    shellHook = ''
      gcc --version | head -n1
      clang --version | head -n1
    '';
  }

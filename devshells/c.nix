{pkgs}:
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
  ];

  shellHook = ''
    mkdir -p .nix-bin

    cat > .nix-bin/clangd-nix <<'EOF'
    #!/usr/bin/env bash
    CLANG="$(command -v clang)"
    exec clangd \
      --query-driver="$CLANG" \
      "$@"
    EOF

    chmod +x .nix-bin/clangd-nix
    export PATH="$PWD/.nix-bin:$PATH"
    gcc --version | head -n1
    clang --version | head -n1
  '';
}

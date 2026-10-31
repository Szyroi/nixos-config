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

    echo "C++ development environment"
    echo "GCC: $(gcc --version | head -n1)"
    echo "Clang: $(clang --version | head -n1)"
    echo "CMake: $(cmake --version | head -n1)"
  '';
}

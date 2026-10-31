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
    export CLANGD_QUERY_DRIVER="$(command -v clang)"
    echo "C development environment"
    echo "Clang wrapper: $CLANGD_QUERY_DRIVER"
    gcc --version | head -n1
    clang --version | head -n1
  '';
}

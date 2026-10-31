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
    echo "C++ development environment"
    g++ --version | head -n1
    cmake --version | head -n1
  '';
}

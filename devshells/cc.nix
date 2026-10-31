{pkgs}:
pkgs.mkShell {
  packages = with pkgs; [
    # Compiler / Toolchains
    gcc
    clang
    clang-tools

    # Build-Systeme
    gnumake
    cmake
    ninja

    # Debugging / Analyse
    gdb
    lldb
    ccache

    # Paket-/Header-Suche
    pkg-config
  ];

  shellHook = ''
    echo "C/C++ devshell"
    gcc --version | head -n1
    clang --version | head -n1
    cmake --version | head -n1
  '';
}

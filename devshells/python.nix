{pkgs}:
pkgs.mkShell {
  packages = with pkgs; [
    python316
    uv
    ty
    ruff
  ];

  shellHook = ''
    echo "Python development environment"
    python --version
    uv --version
  '';
}

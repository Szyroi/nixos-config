{pkgs}:
pkgs.mkShell {
  packages = with pkgs; [
    python316
    uv
    ty
    ruff
  ];

  shellhook = ''
    echo "Python development environment"
    python --version
    uv --version
  '';
}

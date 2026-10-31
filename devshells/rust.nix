{pkgs}:
pkgs.mkShell {
  packages = with pkgs; [
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer

    # häufig nützlich für Rust-Projekte mit nativen Abhängigkeiten
    pkg-config
    openssl

    # optionale Tools
    cargo-watch
    cargo-edit
  ];

  RUST_BACKTRACE = "1";

  shellHook = ''
    echo "Rust development environment"
    rustc --version
    cargo --version
  '';
}

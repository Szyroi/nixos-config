{
  pkgs,
  inputs,
  ...
}: let
  language-servers = with pkgs; [
    hyprls
    fish-lsp
    bash-language-server
    shfmt
    vscode-json-languageserver
    taplo
    yaml-language-server
    systemd-lsp

    lua-language-server
    stylua

    markdown-oxide

    superhtml
    vscode-css-languageserver
    typescript-language-server
    svelte-language-server
    prettierd

    nixd
    alejandra

    jdt-language-server
    google-java-format

    asm-lsp
    haskell-language-server

    clang_22
    llvmPackages_22.clang-tools

    rust-analyzer
    rustfmt
    clippy

    neocmakelsp
    cmake-format

    pyright
    ruff

    tinymist

    texlab
    tex-fmt
  ];

  development = with pkgs; [
    tree-sitter

    statix
    deadnix

    jdk25
    maven

    nasm

    gcc16
    gdb

    cargo
    rustc

    cmake
    ninja

    python3
    python313Packages.pip
    virtualenv
    jupyter

    dbeaver-bin

    nodejs

    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtwayland
    qt6.qttools
    qt6.qtvirtualkeyboard
    qt6.qtmultimedia
    qt6.qt5compat
    inputs.sqldeveloper.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
in {
  programs.nix-ld.enable = true;

  environment.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk25}";
  };

  environment.systemPackages =
    language-servers ++ development;
}

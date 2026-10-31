{pkgs}:
pkgs.mkShell {
  packages = with pkgs; [
    texlive.combined.scheme-full
    latexmk
    texlab
    biber
    chktex

    zathura
    zathura-pdf-mupdf
  ];
}

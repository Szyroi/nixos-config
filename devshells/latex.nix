{pkgs}:
pkgs.mkShell {
  packages = with pkgs; [
    texliveFull
    texlivePackages.latexmk
    texlivePackages.chktex
    texlab
    biber

    zathura
  ];
}

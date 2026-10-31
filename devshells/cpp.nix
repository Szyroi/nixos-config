{pkgs}: let
  cShell = import ./c.nix {inherit pkgs;};
in
  pkgs.mkShell {
    inputsFrom = [cShell];

    packages = with pkgs; [
      # C++-spezifische Werkzeuge bei Bedarf
    ];

    shellHook = ''
      g++ --version | head -n1
    '';
  }

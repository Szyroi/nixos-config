{
  description = "LaTeX project with Zed and Zathura";

  inputs.nixos-config.url = "github:Szyroi/nixos-config";

  outputs = {
    self,
    nixos-config,
  }: let
    system = "x86_64-linux";
  in {
    devShells.${system}.default = nixos-config.devShells.${system}.latex;
  };
}

{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.git = {
    enable = true;
    config = {
      user.name = "Szyroi";
      user.email = "pixelcraft696@gmail.com";
      init.defaultBranch = "main";
    };
  };
}

{pkgs, ...}: {
  home.packages = with pkgs; [
    easyeffects
    obsidian
    vesktop
    anki
    thunderbird

    # Screenshot Utills
    grim
    slurp
    swappy
  ];
}

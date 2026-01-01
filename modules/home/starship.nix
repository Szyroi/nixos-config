# starship.nix
{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;
      scan_timeout = 10;

      format = "[╭─](bold red)[](bold red)$os[ ](bold red)$username$hostname\n[│](bold red)$directory$rust$package\n[╰─](bold red)$character";

      fill = {
        symbol = "";


      };

      character = {
           success_symbol = "[](bold red) ";
           error_symbol = "[✗](bold red) ";
         };

      username = {
        show_always = true;
        #style_user = "bg:#f01d40";
        #style_root = "bg:#f01d40";
        format = ''[$user]($style)'';
        disabled = false;
      };

      hostname = {
        format = "[@$hostname]($style)";
        disabled = false;
        ssh_only = false;
      };

      os = {
        style = "bg:#171717";
        format = "[$symbol ]($style)()";
        disabled = false;
        symbols = {
          Arch = "󰣇";
          NixOS = "  ";
        };
      };

      directory = {
        #style = "bg:#f01d40";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };

      palette = "expo";

      palettes.expo = {

      };

      git_branch = {
        symbol = "";
        style = "bg:#394260";
        format = ''[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)'';
      };

      git_status = {
        style = "bg:#394260";
        format = ''[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)'';
      };

      rust = {
        symbol = "";
        style = "bg:#212736";
        format = ''[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'';
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:#1d2230";
        format = ''[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)'';
      };

      package.disabled = true;
    };
  };
}

{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.wofi = {
    enable = true;

    # Allgemeine Einstellungen
    settings = {
      width = 600;
      height = 400;
      location = "center";
      show = "drun"; # drun, run, combi
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      allow_images = true;
      no_actions = true;
      hide_scrollbar = true;
      term = "alacritty"; # Terminal für Shell-Befehle
      insensitive = true; # Case-insensitive Suche
      parse_search = false;

      # Layout
      mode = "horizontal"; # horizontal, vertical
      lines = 10;
      columns = 1;
      line_wrap = "off";
      cycle = true;
      always_parse_args = true;

      # Verhalten
      gtk_dark = true;
      dynamic_lines = false;
      cache_file = "/dev/null"; # Deaktiviert Cache
    };

    # CSS Styling
    style = ''
      window {
          margin: 0px;
          border: 2px solid #1e1e2e;
          border-radius: 12px;
          background-color: #1e1e2e;
          font-family: "Fira Code", "Symbols Nerd Font";
          font-size: 14px;
      }

      #input {
          margin: 5px;
          border: 2px solid #89b4fa;
          border-radius: 8px;
          color: #cdd6f4;
          background-color: #1e1e2e;
      }

      #input image {
          color: #cdd6f4;
      }

      #inner-box {
          margin: 5px;
          border: none;
          background-color: #1e1e2e;
      }

      #outer-box {
          margin: 5px;
          border: none;
          background-color: #1e1e2e;
      }

      #scroll {
          margin: 0px;
          border: none;
      }

      #text {
          margin: 5px;
          border: none;
          color: #cdd6f4;
      }

      #entry {
          margin: 0px;
          border: none;
          border-radius: 8px;
          background-color: transparent;
          padding: 3px;
      }

      #entry:selected {
          background-color: #585b70;
      }

      #img {
          margin: 5px;
          border: none;
          background-color: transparent;
      }

      #img:selected {
          background-color: #585b70;
      }
    '';
  };
}

{pkgs, ...}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "java-eclipse-jdtls"
      "LaTeX"
    ];
    extraPackages = with pkgs; [
      jdt-language-server
      python3
      rustup
      cargo
      clang
      gcc
      cmake
      nodejs_20
      fd
      ripgrep
      nixd
      nil
      alejandra
      nodePackages.vscode-langservers-extracted
    ];

    userSettings = {
      base_keymap = "VSCode";

      ui_font_weight = 400.0;
      ui_font_size = 16.0;
      ui_font_family = ".ZedSans";
      buffer_line_height = "comfortable";
      buffer_font_weight = 400.0;
      buffer_font_size = 15.0;
      buffer_font_family = "JetBrainsMono Nerd Font";

      prettier = {
        allowed = true;
      };

      format_on_save = "on";

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      terminal = {
        shell = {
          program = "fish";
        };
        working_directory = "current_project_directory";
      };

      theme = {
        mode = "dark";
        dark = "Vercel Dark";
      };

      icon_theme = {
        mode = "dark";
        light = "Colored Zed Icons Theme Light";
        dark = "Colored Zed Icons Theme Dark";
      };
      lsp = {
      };
      languages = {
        Nix = {
          formatter = {
            external = {
              command = "alejandra";
              arguments = [
                "--quiet"
              ];
            };
          };
        };
        Java = {
          show_edit_predictions = false;
          prettier = {
            allowed = true;
          };
          completions = {
            lsp = true;
          };
          enable_language_server = true;
          tasks = {
            prefer_lsp = true;
            enabled = true;
          };
          inlay_hints = {
            show_other_hints = true;
            show_parameter_hints = true;
            show_type_hints = true;
            show_value_hints = true;
            enabled = true;
          };
          show_completion_documentation = true;
          show_completions_on_input = true;
          show_whitespaces = "selection";
          use_auto_surround = true;
          use_autoclose = true;
          ensure_final_newline_on_save = true;
          remove_trailing_whitespace_on_save = true;
          format_on_save = "on";
          allow_rewrap = "in_comments";
          show_wrap_guides = true;
          soft_wrap = "none";
          auto_indent = true;
          auto_indent_on_paste = true;
          indent_guides = {
            active_line_width = 2;
            line_width = 1;
            background_coloring = "disabled";
            coloring = "indent_aware";
            enabled = true;
          };
        };
      };
    };
  };

  home.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk21}";
    GRADLE_USER_HOME = "$HOME/.gradle";
  };
}

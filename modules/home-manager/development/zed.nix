{
  pkgs,
  lib,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "ini"
      "toml"
      "java-eclipse-jdtls"
      "java"
      "LaTeX"
      "sql"
      "make"
      "neocmake"
      "svelte"
      "scss"
      "lua"
      "xml"
      "html"
      "dockerfile"
      "git-firefly"
      "jsonnet"
      "assembly-language-server"
    ];

    userSettings = {
      base_keymap = "VSCode";

      ui_font_weight = 400.0;
      ui_font_size = lib.mkDefault 16.0;
      buffer_font_weight = lib.mkDefault 400.0;
      buffer_font_size = lib.mkDefault 15.0;
      buffer_font_family = lib.mkDefault "JetBrainsMono Nerd Font";
      project_panel = {
        dock = "left";
      };
      prettier.allowed = false;

      linked_edits = true;
      disable_ai = true;
      diagnostics = {
        lsp_pull_diagnostics = {
          enabled = true;
        };
        inline = {
          enabled = true;
        };
        include_warnings = true;
      };

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      terminal = {
        shell = {
          program = "fish";
        };
        working_directory = "current_project_directory";
        cursor_shape = "bar";
      };

      theme = {
        mode = "dark";
        dark = lib.mkDefault "Yuugen - Kage";
        light = lib.mkDefault "Yuugen - Kage";
      };

      icon_theme = {
        mode = "dark";
        light = "Colored Zed Icons Theme Light";
        dark = "Colored Zed Icons Theme Dark";
      };

      format_on_save = "on";

      show_completion_documentation = true;
      show_completions_on_input = true;

      use_auto_surround = true;
      use_autoclose = true;

      ensure_final_newline_on_save = true;
      remove_trailing_whitespace_on_save = true;

      indent_guides = {
        active_line_width = 2;
        line_width = 1;
        coloring = "indent_aware";
        enabled = true;
      };

      inlay_hints = {
        show_other_hints = false;
        show_parameter_hints = false;
        show_type_hints = false;
        show_value_hints = false;
        enabled = false;
      };

      completions = {
        lsp = true;
      };

      lsp = {
        "clangd" = {
          initialization_options = {
            "compilationDatabasePath" = "build/clang";
          };
        };
        "qmljs" = {
          binary = {
            arguments = [
              "-E"
              "additional-args"
            ];
          };
        };
        "lua-language-server" = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT";
              };

              diagnostics = {
                globals = ["hl"];
              };

              workspace = {
                library = [
                  "${pkgs.hyprland}/share/hypr"
                ];

                checkThirdParty = false;
              };
            };
          };
        };
      };

      languages = {
        Nix = {
          language_servers = ["nixd"];
          formatter = {
            external = {
              command = "alejandra";
              arguments = ["--quiet"];
            };
          };
        };
        C = {
          language_servers = ["clangd"];
          formatter = {
            external = {
              command = "clang-format";
              arguments = [];
            };
          };
        };
        Java = {
          language_servers = ["jdtls"];
        };
        CMake = {
          formatter = {
            external = {
              command = "cmake-format";
              arguments = ["-"];
            };
          };
        };
        Assembly = {
          language_servers = ["asm-lsp"];
        };
        Python = {
          language_servers = [
            "ruff"
            "pyright"
          ];
          formatter = {
            external = {
              command = "ruff";
              arguments = [
                "format"
                "-"
              ];
            };
          };
        };

        texlab = {
          settings = {
            texlab = {
              build = {
                onSave = true;
                executable = "latexmk";
                args = [
                  "-f"
                  "-pdf"
                  "-interaction=nonstopmode"
                  "-synctex=1"
                ];
                outputDirectory = "build";
              };
              forwardSearch = {
                executable = "zathura";
                args = [
                  "--synctex-forward"
                  "%l:%c:%p"
                  "%p"
                ];
              };
            };
          };
        };

        Lua = {
          language_servers = ["lua-language-server"];
          formatter = {
            external = {
              command = "stylua";
              arguments = ["-"];
            };
          };
        };
      };
    };
  };
}

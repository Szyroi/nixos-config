{
  config,
  lib,
  pkgs,
  ...
}:
{
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
      alejandra
      nodePackages.vscode-langservers-extracted
    ];

    userSettings = {
      base_keymap = "VSCode";

      prettier = {
        allowed = true;
      };

      format_on_save = {
        enabled = true;
        language_server = {
          java = "jdt-language-server";
          nix = "nixd";
        };
      };

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      terminal = {
        shell = {
          program = "fish";
          args = [ "-l" ];
        };
        working_directory = "project";
        copy_on_select = false;
      };

      theme = {
        mode = "light";
        light = "Vercel Light";
        dark = "Vercel Dark";
      };
      icon_theme = {
        mode = "dark";
        light = "Colored Zed Icons Theme Light";
        dark = "Colored Zed Icons Theme Dark";
      };
      lsp = {

        "jdt-language-server" = {
          settings = {
            java = {
              format = {
                enabled = true;
                settings = {
                  url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml";
                  profile = "GoogleStyle";
                };
              };
              saveActions = {
                organizeImports = true;
              };
              completion = {
                guessMethodArguments = true;
              };
            };
          };

          initialization_options = {
            bundles =
              let
                jdtls = pkgs.jdt-language-server;
              in
              [
                "${jdtls}/share/java/jdtls/plugins/org.eclipse.equinox.launcher.jar"
              ];
            workspace = "~/.cache/zed/jdtls-workspace";
            extendedClientCapabilities = {
              progressReportProvider = true;
            };
          };
        };

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
          indent = {
            unit = 2;
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

{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    enableMan = true;
    globals.mapleader = " ";

    colorschemes = {
      oxocarbon.enable = true;
    };

    opts = {
      number = true;
      rnu = true;
      wrap = false;
      tabstop = 2;
      shiftwidth = 2;
      smartindent = true;
    };

    plugins = {
      nix.enable = true;
      lazygit.enable = true;
      which-key.enable = true;
      web-devicons.enable = false;
      oil.enable = true;
      harpoon.enable = true;
      undotree.enable = true;
      trouble.enable = true;

      treesitter = {
        enable = true;
        nixGrammars = true;
        indent.enable = true;
      };

      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          file-browser.enable = true;
        };
      };

      lualine = {
        enable = true;
        theme = "auto";
        settings = {
          sections = {
            lualine_a = ["mode"];
            lualine_b = ["branch" "diff" "diagnostics"];
            lualine_c = ["filename"];
            lualine_x = ["encoding" "fileformat" "filetype"];
            lualine_y = ["progress"];
            lualine_z = ["location"];
          };
        };
      };

      dashboard = {
        enable = true;
        settings = {
          change_to_vcs_root = true;
          config = {
            footer = [
              "Made with ❤️"
            ];
            header = [
              "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
              "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
              "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
              "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
              "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
              "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
            ];
            mru = {
              limit = 20;
            };
            project = {
              enable = false;
            };
            shortcut = [
              {
                action = {
                  __raw = "function(path) vim.cmd('Telescope find_files') end";
                };
                desc = "Files";
                group = "Label";
                icon = " ";
                icon_hl = "@variable";
                key = "f";
              }
              {
                action = "Telescope app";
                desc = " Apps";
                group = "DiagnosticHint";
                key = "a";
              }
              {
                action = "Telescope dotfiles";
                desc = " dotfiles";
                group = "Number";
                key = "d";
              }
            ];
            week_header = {
              enable = true;
            };
            theme = "hyper";
          };
        };
      };

      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          lspBuf = {
            gd = "definition";
            gD = "declaration";
            gr = "references";
            gi = "implementation";
            K = "hover";
            "<leader>ca" = "code_action";
            "<leader>rn" = "rename";
            "<leader>f" = "format";
          };
        };

        servers = {
          lua_ls.enable = true;
          nil_ls.enable = true;
          jdtls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
        };
      };
    };

    extraPackages = with pkgs; [
      # Formatter/Linter
      alejandra # Nix
      nixpkgs-fmt # Alternative für Nix
      stylua # Lua
      rustfmt # Rust
      nodePackages.prettier # JS/TS/CSS/HTML
      jdk25 # Java

      # Tools
      ripgrep # Für Telescope live_grep
      fd # Für Telescope find_files
      lsof # Für Debugging

      # LSPs
      lua-language-server
      rust-analyzer
      nil # Nix LSP
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted # HTML/CSS/JSON
      yaml-language-server
    ];

    keymaps = [
      # Navigation
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
      }

      # Telescope
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
      }

      # Clipboard
      {
        mode = ["v"];
        key = "<leader>y";
        action = "\"+y";
      }
      {
        mode = ["n"];
        key = "<leader>Y";
        action = "\"+Y";
      }
      {
        mode = ["n"];
        key = "<leader>p";
        action = "\"+p";
      }

      # Buffer Management
      {
        mode = "n";
        key = "<leader>bd";
        action = ":bd<CR>";
      }
      {
        mode = "n";
        key = "<leader>bn";
        action = ":bn<CR>";
      }
      {
        mode = "n";
        key = "<leader>bp";
        action = ":bp<CR>";
      }
    ];
  };
}

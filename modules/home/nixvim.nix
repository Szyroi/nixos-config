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

    colorschemes = {
      catppuccin.enable = true;
    };

    opts = {
      number = true;
      rnu = true;
    };

    plugins = {
      nix.enable = true;
      lazygit.enable = true;
      which-key.enable = true;
      wtf.enable = true;
      yazi.enable = true;
      fzf-lua.enable = true;
      snacks.enable = true;
      web-devicons.enable = false;
      lualine.enable = true;
      treesitter.enable = true;
      telescope.enable = true;
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
        servers = {
          lua_ls.enable = true;
          nil_ls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          ts_ls.enable = true;
        };
      };
    };

    extraPackages = with pkgs; [
      nil
      lua-language-server
      rust-analyzer
      nodePackages.typescript-language-server
      stylua
      shfmt
      alejandra
    ];

    keymaps = [
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
        key = "<leader>sn";
        action = "<cmd>SnacksOpen<CR>";
      }
    ];
  };
}

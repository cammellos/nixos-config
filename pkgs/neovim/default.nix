{
  config,
  pkgs,
  inputs,
  user,
  ...
}:

let
  gitlab-nvim = import ./gitlab.nix { inherit pkgs; };
in
{
  users.users."${user}".packages = with pkgs; [ neovide ];

  environment.variables = {
    EDITOR = "nvim";
    # doesn't play well with nested nvim
    GIT_EDITOR = "neovide --no-fork --grid 120x30";
    SOPS_EDITOR = "neovide --no-fork --grid 120x30";
    # since we run everything through the terminal, is not available on
    # to the editor when direnv is used
    RUST_ANALYZER_USE_SYSROOT = "true";
  };
  environment.systemPackages = [
    pkgs.pass
    # for copilot
    pkgs.nodejs
    pkgs.pass-wayland
  ];
  services.dbus.packages = with pkgs; [
    pass-secret-service
  ];
  services.passSecretService.enable = true;
  home-manager.users."${user}" = {
    xdg.configFile.nvim = {
      source = ./config;
      recursive = true;
    };

    programs.ripgrep = {
      enable = true;
    };
    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        plenary-nvim
        {
          plugin = typescript-tools-nvim;
          config = ''
            require('typescript-tools').setup({})
          '';

          type = "lua";
        }
        {
          plugin = nord-vim;
          config = ''
            vim.cmd('colorscheme nord')
          '';
          type = "lua";
        }
        # gitlab plugin depedency
        {
          plugin = diffview-nvim;
          type = "lua";
          config = ''
            require("diffview").setup({});
          '';
        }
        # gitlab plugin depedency
        dressing-nvim
        {
          plugin = gitlab-nvim;
          type = "lua";
          config = ''
            require("gitlab").setup({});
          '';
        }
        {
          plugin = term-edit-nvim;
          config = ''
            require('term-edit').setup({
              prompt_end = '%$ ',
            })
          '';
          type = "lua";
        }
        {
          plugin = oil-nvim;
          config = ''
            require("oil").setup()
          '';
          type = "lua";
        }
        {
          plugin = project-nvim;
          config = ''
            require("project_nvim").setup {}
          '';
          type = "lua";
        }
        {
          plugin = telescope-nvim;
          config = ''

            local telescope_builtin = require('telescope.builtin')
            vim.keymap.set('n', ',h', telescope_builtin.find_files, {})
            vim.keymap.set('n', ',g', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', 'fr', telescope_builtin.lsp_references, { noremap = true, silent = true })

          '';
          type = "lua";
        }
        {
          plugin = nvim-treesitter.withAllGrammars;
          config = ''
            require'nvim-treesitter.configs'.setup {
              highlight = {
                enable = true
                },
              additional_vim_regex_highlighting = false,
            }
          '';
          type = "lua";
        }
        plenary-nvim
        {
          plugin = CopilotChat-nvim;
          config = ''
            require("copilot").setup({});
            require("CopilotChat").setup {
              -- See Configuration section for options
            }
          '';
          type = "lua";
        }
        {
          plugin = telescope-ui-select-nvim;
          config = ''
            require("telescope").setup {
              extensions = { ["ui-select"] = {}}
            }
            require("telescope").load_extension("ui-select")
          '';
          type = "lua";
        }
        {
          plugin = flutter-tools-nvim;
          config = ''
            require("flutter-tools").setup {}
          '';
          type = "lua";
        }
        {
          plugin = lsp-format-nvim;
          config = ''
            require("lsp-format").setup {}
          '';
          type = "lua";

        }
        {
          plugin = nvim-lspconfig;
          config = ''
             local lspconfig = require("lspconfig")
             local lspformat = require("lsp-format")

             lspconfig.rust_analyzer.setup { on_attach = lspformat.on_attach }
             lspconfig.gopls.setup { on_attach = lspformat.on_attach }
             lspconfig.dartls.setup { on_attach = lspformat.on_attach }
             lspconfig.clojure_lsp.setup({on_attach = lspformat.on_attach})
             lspconfig.gleam.setup({on_attach = lspformat.on_attach})
             lspconfig.elixirls.setup({
               cmd = { "${pkgs.elixir-ls}/bin/elixir-ls"},
               root_dir = function(fname)
                  return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.cwd()
               end,
               filetypes = { "elixir", "eelixir", "heex" },
               on_attach = lspformat.on_attach,
             })

            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

            vim.api.nvim_set_keymap('n', 'gb', ':pop<CR>', { noremap = true, silent = true })
          '';
          type = "lua";
        }
        {
          plugin = rust-tools-nvim;
          config = ''
            local rt = require("rust-tools")

            rt.setup({
              server = {
                on_attach = function(_, bufnr)
                  -- Hover actions
                  vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                  -- Code action groups
                  vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                end,
              },
            })
          '';
          type = "lua";
        }
        nui-nvim
        {
          plugin = noice-nvim;
          config = ''
            require("noice").setup({
              lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                  ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                  ["vim.lsp.util.stylize_markdown"] = true,
                  ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
              },
              -- you can enable a preset for easier configuration
              presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
              },
            })
          '';
          type = "lua";
        }
        {
          plugin = conform-nvim;
          config = ''
            require("conform").setup({
            formatters_by_ft = {
            rust = { "rustfmt"},
            },
            format_on_save = {
            timeout_ms = 500,
            },
            });
          '';
          type = "lua";
        }
        {
          plugin = vim-better-whitespace;
          config = ''
            vim.g.better_whitespace_enabled = 1
            vim.g.strip_whitespace_on_save = 1
            vim.g.strip_whitespace_confirm = 0
            vim.cmd "let g:better_whitespace_filetypes_blacklist = ['gitsendemail', 'diff', 'gitcommit', 'unite', 'qf', 'help', 'mail']"
          '';
          type = "lua";
        }
        vim-nix
        vim-gitgutter
        vim-go
      ];
      extraConfig = ''
        :luafile ~/.config/nvim/lua/init.lua
      '';
    };
  };

}

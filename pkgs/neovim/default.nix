{
  config,
  pkgs,
  user,
  ...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
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
        {
          plugin = pkgs.kitty-scrollback;
          config = ''
            require('kitty-scrollback').setup()
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
          plugin = telescope-nvim;
          config = ''

            local telescope_builtin = require('telescope.builtin')
            vim.keymap.set('n', ',h', telescope_builtin.find_files, {})

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

            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

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
        {
          plugin = nord-vim;
          config = ''
            vim.cmd('colorscheme nord')
          '';
          type = "lua";
        }
        {
          plugin = ChatGPT-nvim;
          config = ''
            local home = vim.fn.expand("$HOME")
            require("chatgpt").setup({
              api_key_cmd = home .. "/.local/bin/chat-gpt-key.sh",
              chat = {
                keymaps = {
                  edit_message = "<C-e>",
                },
              },
            })
          '';
          type = "lua";
        }
      ];
      extraConfig = ''
        :luafile ~/.config/nvim/lua/init.lua
      '';
    };
  };

}

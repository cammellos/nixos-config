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

    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
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
          type  = "lua";
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
        {
          plugin = rainbow;
          config = ''
            vim.g.rainbow_active = 1
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

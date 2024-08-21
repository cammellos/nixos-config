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

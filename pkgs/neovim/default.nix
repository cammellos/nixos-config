{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  home-manager.users.cammellos.programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
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
    ];
    extraConfig = ''
      :luafile ~/.config/nvim/lua/init.lua
    '';
  };
  home-manager.users.cammellos.xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}

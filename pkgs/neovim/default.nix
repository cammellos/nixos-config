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
    plugins = with pkgs.vimPlugins; [ vim-nix ];
    extraConfig = ''
      :luafile ~/.config/nvim/lua/init.lua
    '';
  };
  home-manager.users.cammellos.xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}

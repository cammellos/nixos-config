{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [ alacritty-theme ];
  nixpkgs.config.input-fonts.acceptLicense = true;
  home-manager.users.cammellos.programs.alacritty = {
    enable = true;
    settings = {
      import = [ "${pkgs.alacritty-theme}/nord.toml" ];
      font.size = 12;
      font.normal.family = "Inconsolata Nerd Font Mono";
      selection.save_to_clipboard = true;
    };
  };
}

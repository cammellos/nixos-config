{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [ alacritty-theme ];
  nixpkgs.config.input-fonts.acceptLicense = true;
  home-manager.users.cammellos.programs.alacritty = {
    enable = true;
    settings = {
      import = [ "${pkgs.alacritty-theme}/nord.toml" ];
      font.size = 9;
      font.normal.family = "Input Mono";
      selection.save_to_clipboard = true;
    };
  };
}

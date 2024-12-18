{ config, pkgs, ... }:
{
  nixpkgs.config.input-fonts.acceptLicense = true;

  home-manager.users.cammellos = {
    home.file = {
      ".local/bin/remote-kitty.sh".source = ./remote-kitty.sh;
      ".config/kitty/launch.conf".source = ./launch.conf;
    };

    programs.kitty = {
      enable = true;
      themeFile = "Nord";
      font = {
        name = "Inconsolata Nerd Font Mono";
        size = 12.0;
      };
      settings = {
        background_opacity = "0.95";
      };
    };
  };
}

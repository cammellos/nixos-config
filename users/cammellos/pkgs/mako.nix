{ pkgs, config, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    libnotify
  ];
  home-manager.users.cammellos = {
    services.mako = {
      enable = true;
      settings = {
        icons = true;
        defaultTimeout = 4000;
        backgroundColor = "#3b4252";
        textColor = "#d8dee9";
        borderColor = "#88c0d0";
        borderSize = 3;
        layer = "top";
        maxVisible = 10;
        borderRadius = 3;
        margin = "20";
        anchor = "bottom-right";
        font = "JetBrainsMono Nerd Font Propo 10";
      };
    };
  };
}

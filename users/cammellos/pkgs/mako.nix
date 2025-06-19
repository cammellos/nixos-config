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
        default-timeout = 4000;
        background-color = "#3b4252";
        text-color = "#d8dee9";
        border-color = "#88c0d0";
        border-size = 3;
        layer = "top";
        max-visible = 10;
        border-radius = 3;
        margin = "20";
        anchor = "bottom-right";
        font = "JetBrainsMono Nerd Font Propo 10";
      };
    };
  };
}

{ config, pkgs, ... }:
{
  home-manager.users.cammellos = {
    home.stateVersion = "24.05";
    home.username = "cammellos";
    home.homeDirectory = "/home/cammellos";
  };
}

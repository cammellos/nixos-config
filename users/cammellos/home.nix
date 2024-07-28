{ config, pkgs, ... }:
{
  home-manager.users.cammellos.home = {
    stateVersion = "24.05";
    username = "cammellos";
    homeDirectory = "/home/cammellos";
  };
}

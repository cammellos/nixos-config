{ config, pkgs, ... }:
{
  home-manager.users.cammellos.programs.git = {
    enable = true;
    userName = "Andrea Maria Piana";
    userEmail = "andrea.maria.piana@gmail.com";
  };
}

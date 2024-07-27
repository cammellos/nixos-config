{ config, pkgs, ... }:
{
  home-manager.users.root = {
    home.stateVersion = "24.05";
    home.username = "root";
    home.homeDirectory = "/root";
  };
}

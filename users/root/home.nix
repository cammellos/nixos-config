{ config, pkgs, ... }:
{
  home-manager.users.root.home = {
    stateVersion = "24.05";
    username = "root";
    homeDirectory = "/root";
  };
}

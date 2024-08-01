{ config, pkgs, ... }:
{

  home-manager.users.cammellos.home.file.".taskrc".source = ./config/taskrc;

  users.users.cammellos.packages = with pkgs; [ taskwarrior ];
}

{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    pasystray
    tidal-hifi
    spotify
    pavucontrol
  ];
}


{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    lutris
    wineWowPackages.stable
    wineWowPackages.waylandFull
  ];
}

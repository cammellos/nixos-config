{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [
      lutris
      wine64
    ];
}

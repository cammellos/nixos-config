{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    deluge
    librewolf
    discord
    vlc
  ];
}

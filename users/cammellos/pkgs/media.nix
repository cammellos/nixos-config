{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    deluge
    librewolf
    vlc
  ];
}

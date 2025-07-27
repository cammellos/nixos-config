{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    godot
    aseprite
  ];
}

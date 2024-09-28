{ config, pkgs, ...}:
{
  programs.adb.enable = true;
  users.users.cammellos.extraGroups = ["adbusers"];
}

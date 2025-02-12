{ config, pkgs, ... }:
{
  programs.ydotool = {
    enable = true;
    group = "users";
  };
}

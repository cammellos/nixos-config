{ pkgs, config, ... }:
{
  home-manager.users.cammellos.home.file.".config/dunst/dunstrc".source = ./config/dunstrc;
  users.users.cammellos.packages = with pkgs; [
    dunst
    libnotify
  ];
}

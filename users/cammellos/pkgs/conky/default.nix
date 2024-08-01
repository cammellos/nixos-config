{ pkgs, config, ... }:
{
  home-manager.users.cammellos.home.file.".config/conky/conky.conf".source = ./config/conky.conf;
  users.users.cammellos.packages = with pkgs; [ conky ];

}

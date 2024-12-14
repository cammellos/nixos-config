{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    entr
    silver-searcher
    jq
    gh
    gnumake
    unzip
    gcc
  ];
}

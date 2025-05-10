{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    entr
    silver-searcher
    jq
    gh
    python3
    gnumake
    unzip
    gcc
  ];
}

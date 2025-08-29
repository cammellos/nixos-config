{ config, pkgs, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    entr
    silver-searcher
    gleam
    cargo
    rust-analyzer
    jq
    gh
    python3
    gnumake
    unzip
    gcc
  ];
}

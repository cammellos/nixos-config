{ config, pkgs, ... }:
{
  imports = [
    ./user.nix
    ./pkgs/ledger.nix
  ];
}

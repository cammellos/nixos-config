{ config, pkgs, ... }:
{
  imports = [
    ./user.nix
    ./home.nix
    ./pkgs/ledger.nix
    ./pkgs/git.nix
  ];
}

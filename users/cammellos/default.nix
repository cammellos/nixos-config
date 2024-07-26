{ config, pkgs, ... }:
{
  imports = [
    ./user.nix
    ./home.nix
    ./pkgs/ledger.nix
    ./pkgs/git.nix
    ./pkgs/status
    ./pkgs/gaming.nix
    ./pkgs/clojure.nix
    ./pkgs/media.nix
    ./pkgs/golang.nix
  ];
}
